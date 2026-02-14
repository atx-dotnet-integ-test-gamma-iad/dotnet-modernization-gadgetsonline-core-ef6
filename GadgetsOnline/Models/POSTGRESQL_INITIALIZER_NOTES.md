# PostgreSQL Database Initializer Notes

## GadgetsOnlineInitializer - PostgreSQL Migration Considerations

### Overview
The `GadgetsOnlineInitializer` class uses EF6's `CreateDatabaseIfNotExists<T>` strategy, which is compatible with PostgreSQL through the Npgsql EF6 provider. However, there are important considerations for PostgreSQL compatibility.

---

## Critical Issues and Solutions

### 1. Identity/Sequence Handling

**Issue**: The seed data explicitly sets `CategoryId` and `ProductId` values (1, 2, 3, etc.). In PostgreSQL, this bypasses the auto-increment sequences but doesn't update them.

**Impact**: After initial seeding, when new records are inserted, PostgreSQL sequences will start from 1, causing duplicate key violations.

**Solution Options**:

#### Option A: Reset Sequences After Seeding (Recommended)

After the first run with seed data, execute these SQL commands:

```sql
-- Reset Categories sequence
SELECT setval(
    pg_get_serial_sequence('"Categories"', '"CategoryId"'), 
    (SELECT MAX("CategoryId") FROM "Categories")
);

-- Reset Products sequence
SELECT setval(
    pg_get_serial_sequence('"Products"', '"ProductId"'), 
    (SELECT MAX("ProductId") FROM "Products")
);
```

**Automated Approach**: Add this to the `Seed` method after `context.SaveChanges()`:

```csharp
context.SaveChanges();

// Reset PostgreSQL sequences to prevent duplicate key violations
context.Database.ExecuteSqlCommand(
    @"SELECT setval(pg_get_serial_sequence('""Categories""', '""CategoryId""'), 
      (SELECT COALESCE(MAX(""CategoryId""), 1) FROM ""Categories""));");

context.Database.ExecuteSqlCommand(
    @"SELECT setval(pg_get_serial_sequence('""Products""', '""ProductId""'), 
      (SELECT COALESCE(MAX(""ProductId""), 1) FROM ""Products""));");
```

#### Option B: Remove Explicit ID Assignments

Modify the seed data to let PostgreSQL auto-generate IDs:

```csharp
var categories = new List<Category>
{
    new Category { Name = "Mobile Phones", Description = "Latest collection of Mobile Phones" },
    new Category { Name = "Laptops", Description = "Latest Laptops in 2022" },
    // ... etc (remove CategoryId assignments)
};
```

**Trade-off**: This approach is cleaner but the IDs may differ if the database is recreated.

---

### 2. CreateDatabaseIfNotExists Strategy

**Status**: ✅ Compatible with PostgreSQL

The `CreateDatabaseIfNotExists<T>` strategy works with PostgreSQL via Npgsql. The initializer is properly configured in `Startup.cs`:

```csharp
Database.SetInitializer(new GadgetsOnlineInitializer());
```

And triggered in the `Configure` method:

```csharp
using (var context = new GadgetsOnlineEntities(Configuration.GetConnectionString(nameof(GadgetsOnlineEntities))))
{
    context.Database.Initialize(force: false);
}
```

---

### 3. Data Type Compatibility

**Status**: ✅ No issues detected

- **Decimal values** (e.g., `699.00M`): C# decimal literal syntax, compatible with PostgreSQL numeric/decimal types
- **String values**: All string data is standard and compatible
- **Foreign keys**: `CategoryId` references are properly maintained

---

## Testing Checklist

After PostgreSQL migration, verify:

- [ ] Database is created successfully on first run
- [ ] Seed data is inserted correctly
- [ ] All 5 categories are present
- [ ] All 13 products are present with correct foreign key references
- [ ] Sequences are reset (if using Option A)
- [ ] New category insertion works without duplicate key errors
- [ ] New product insertion works without duplicate key errors
- [ ] Data types map correctly (decimal prices, varchar names)

---

## Common Errors and Solutions

### Error: "duplicate key value violates unique constraint"

**Cause**: Sequences not reset after explicit ID seeding

**Solution**: Execute the sequence reset SQL commands above

### Error: "relation \"Categories\" does not exist"

**Cause**: Schema mapping mismatch (table names case-sensitive in PostgreSQL)

**Solution**: Verify entity classes have correct `[Table]` attributes with schema names

---

## Additional Resources

- [Npgsql EF6 Provider Documentation](https://www.npgsql.org/efcore/)
- [PostgreSQL Sequences Documentation](https://www.postgresql.org/docs/current/functions-sequence.html)
- Entity class transformations: See individual entity files (Category.cs, Product.cs)

---

## Maintenance Notes

When adding new seed data:

1. Follow the existing pattern for consistency
2. If using explicit IDs, ensure sequences are reset
3. Test insertions after seeding to verify sequences work
4. Consider using GUID primary keys for future tables to avoid sequence issues

using GadgetsOnline.Models;
using Npgsql;
using System;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Data.Entity.ModelConfiguration.Conventions;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace GadgetsOnline.Models
{
    // ---------------------------------------------------------------------------
    // EF6 PostgreSQL provider configuration
    // Registers the Npgsql provider services so that Entity Framework 6
    // resolves the correct ADO.NET driver at runtime.
    // ---------------------------------------------------------------------------
    public class GadgetsOnlineEntitiesPostgreSqlConfiguration : DbConfiguration
    {
        public GadgetsOnlineEntitiesPostgreSqlConfiguration()
        {
            SetProviderServices("Npgsql", NpgsqlServices.Instance);
        }
    }

    [DbConfigurationType(typeof(GadgetsOnlineEntitiesPostgreSqlConfiguration))]
    public class GadgetsOnlineEntities : DbContext
    {
        // Default constructor using connection string name from config
        public GadgetsOnlineEntities() : base("name=GadgetsOnlineEntities")
        {
            // Enable lazy loading by default (alternative to AutoInclude)
            this.Configuration.LazyLoadingEnabled = true;
            this.Configuration.ProxyCreationEnabled = true;
        }

        // Constructor with explicit connection string
        public GadgetsOnlineEntities(string dbConn) : base(dbConn)
        {
            this.Configuration.LazyLoadingEnabled = true;
            this.Configuration.ProxyCreationEnabled = true;
        }

        public DbSet<Product> Products { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Cart> Carts { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<OrderDetail> OrderDetails { get; set; }

        // -----------------------------------------------------------------------
        // DateTime UTC compatibility: Npgsql requires all DateTime values stored
        // in timestamptz columns to carry DateTimeKind.Utc.  These overrides
        // normalise every Added/Modified entity before hitting the database.
        // -----------------------------------------------------------------------
        public override int SaveChanges()
        {
            FixDateTimeKinds();
            return base.SaveChanges();
        }

        public override Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
        {
            FixDateTimeKinds();
            return base.SaveChangesAsync(cancellationToken);
        }

        private void FixDateTimeKinds()
        {
            var entries = ChangeTracker.Entries()
                .Where(e => e.State == EntityState.Added || e.State == EntityState.Modified);

            foreach (var entry in entries)
            {
                foreach (var property in entry.CurrentValues.PropertyNames)
                {
                    var value = entry.CurrentValues[property];
                    if (value is DateTime dateTime && dateTime.Kind != DateTimeKind.Utc)
                    {
                        entry.CurrentValues[property] = DateTime.SpecifyKind(dateTime, DateTimeKind.Utc);
                    }
                }
            }
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            // -------------------------------------------------------------------
            // Schema + column name mappings  (dbo  ->  gadgetsonline_dbo)
            // Every stored property is mapped explicitly so that EF generates
            // lower-case identifiers that match the PostgreSQL target schema.
            // EF6 uses local-variable method-chaining on EntityTypeConfiguration<T>
            // (the EF Core lambda-action overload does not exist in EF6).
            // -------------------------------------------------------------------

            // Product
            var productConfig = modelBuilder.Entity<Product>();
            productConfig.ToTable("products", "gadgetsonline_dbo");
            productConfig.Property(e => e.ProductId).HasColumnName("productid");
            productConfig.Property(e => e.CategoryId).HasColumnName("categoryid");
            productConfig.Property(e => e.Name).HasColumnName("name");
            productConfig.Property(e => e.Price).HasColumnName("price");
            productConfig.Property(e => e.ProductArtUrl).HasColumnName("productarturl");

            // Category
            var categoryConfig = modelBuilder.Entity<Category>();
            categoryConfig.ToTable("categories", "gadgetsonline_dbo");
            categoryConfig.Property(e => e.CategoryId).HasColumnName("categoryid");
            categoryConfig.Property(e => e.Name).HasColumnName("name");
            categoryConfig.Property(e => e.Description).HasColumnName("description");

            // Cart
            var cartConfig = modelBuilder.Entity<Cart>();
            cartConfig.ToTable("carts", "gadgetsonline_dbo");
            cartConfig.Property(e => e.RecordId).HasColumnName("recordid");
            cartConfig.Property(e => e.CartId).HasColumnName("cartid");
            cartConfig.Property(e => e.ProductId).HasColumnName("productid");
            cartConfig.Property(e => e.Count).HasColumnName("count");
            cartConfig.Property(e => e.DateCreated).HasColumnName("datecreated");

            // Order
            var orderConfig = modelBuilder.Entity<Order>();
            orderConfig.ToTable("orders", "gadgetsonline_dbo");
            orderConfig.Property(e => e.OrderId).HasColumnName("orderid");
            orderConfig.Property(e => e.OrderDate).HasColumnName("orderdate");
            orderConfig.Property(e => e.Username).HasColumnName("username");
            orderConfig.Property(e => e.FirstName).HasColumnName("firstname");
            orderConfig.Property(e => e.LastName).HasColumnName("lastname");
            orderConfig.Property(e => e.Address).HasColumnName("address");
            orderConfig.Property(e => e.City).HasColumnName("city");
            orderConfig.Property(e => e.State).HasColumnName("state");
            orderConfig.Property(e => e.PostalCode).HasColumnName("postalcode");
            orderConfig.Property(e => e.Country).HasColumnName("country");
            orderConfig.Property(e => e.Phone).HasColumnName("phone");
            orderConfig.Property(e => e.Email).HasColumnName("email");
            orderConfig.Property(e => e.Total).HasColumnName("total");

            // OrderDetail
            var orderDetailConfig = modelBuilder.Entity<OrderDetail>();
            orderDetailConfig.ToTable("orderdetails", "gadgetsonline_dbo");
            orderDetailConfig.Property(e => e.OrderDetailId).HasColumnName("orderdetailid");
            orderDetailConfig.Property(e => e.OrderId).HasColumnName("orderid");
            orderDetailConfig.Property(e => e.ProductId).HasColumnName("productid");
            orderDetailConfig.Property(e => e.Quantity).HasColumnName("quantity");
            orderDetailConfig.Property(e => e.UnitPrice).HasColumnName("unitprice");

            // -------------------------------------------------------------------
            // Relationship configurations  (preserved exactly from original)
            // -------------------------------------------------------------------

            // Configure relationships
            modelBuilder.Entity<Category>()
                .HasMany(c => c.Products)
                .WithRequired(p => p.Category)
                .HasForeignKey(p => p.CategoryId);

            modelBuilder.Entity<Cart>()
                .HasRequired(c => c.Product)
                .WithMany()
                .HasForeignKey(c => c.ProductId);

            modelBuilder.Entity<Order>()
                .HasMany(o => o.OrderDetails)
                .WithRequired(od => od.Order)
                .HasForeignKey(od => od.OrderId);

            modelBuilder.Entity<OrderDetail>()
                .HasRequired(od => od.Product)
                .WithMany()
                .HasForeignKey(od => od.ProductId);
        }
    }
}

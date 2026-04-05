using GadgetsOnline.Models;
using Npgsql;
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace GadgetsOnline.Models
{
    public class GadgetsOnlineEntities : DbContext
    {
// Default constructor using DbContextOptions
        public GadgetsOnlineEntities(DbContextOptions<GadgetsOnlineEntities> options) : base(options)
        {
        }

        public DbSet<Product> Products { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Cart> Carts { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<OrderDetail> OrderDetails { get; set; }

        // ---------------------------------------------------------------------------
        // DateTime UTC fix: ensures all DateTime values are stored as UTC in PostgreSQL
        // ---------------------------------------------------------------------------
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
                foreach (var property in entry.Properties)
                {
                    var value = property.CurrentValue;
                    if (value is DateTime dateTime && dateTime.Kind != DateTimeKind.Utc)
                    {
                        property.CurrentValue = DateTime.SpecifyKind(dateTime, DateTimeKind.Utc);
                    }
                }
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // -----------------------------------------------------------------------
            // Product: table + column mappings  (schema: gadgetsonline_dbo)
            // -----------------------------------------------------------------------
            modelBuilder.Entity<Product>(entity =>
            {
                entity.ToTable("products", "gadgetsonline_dbo");
                entity.Property(e => e.ProductId).HasColumnName("productid");
                entity.Property(e => e.CategoryId).HasColumnName("categoryid");
                entity.Property(e => e.Name).HasColumnName("name");
                entity.Property(e => e.Price).HasColumnName("price");
                entity.Property(e => e.ProductArtUrl).HasColumnName("productarturl");
            });

            // -----------------------------------------------------------------------
            // Category: table + column mappings  (schema: gadgetsonline_dbo)
            // -----------------------------------------------------------------------
            modelBuilder.Entity<Category>(entity =>
            {
                entity.ToTable("categories", "gadgetsonline_dbo");
                entity.Property(e => e.CategoryId).HasColumnName("categoryid");
                entity.Property(e => e.Name).HasColumnName("name");
                entity.Property(e => e.Description).HasColumnName("description");

                // Preserve existing relationship
                entity.HasMany(c => c.Products)
                    .WithOne(p => p.Category)
                    .HasForeignKey(p => p.CategoryId);
            });

            // -----------------------------------------------------------------------
            // Cart: table + column mappings  (schema: gadgetsonline_dbo)
            // -----------------------------------------------------------------------
            modelBuilder.Entity<Cart>(entity =>
            {
                entity.ToTable("carts", "gadgetsonline_dbo");
                entity.Property(e => e.RecordId).HasColumnName("recordid");
                entity.Property(e => e.CartId).HasColumnName("cartid");
                entity.Property(e => e.ProductId).HasColumnName("productid");
                entity.Property(e => e.Count).HasColumnName("count");
                entity.Property(e => e.DateCreated).HasColumnName("datecreated");

                // Preserve existing relationship
                entity.HasOne(c => c.Product)
                    .WithMany()
                    .HasForeignKey(c => c.ProductId);
            });

            // -----------------------------------------------------------------------
            // Order: table + column mappings  (schema: gadgetsonline_dbo)
            // -----------------------------------------------------------------------
            modelBuilder.Entity<Order>(entity =>
            {
                entity.ToTable("orders", "gadgetsonline_dbo");
                entity.Property(e => e.OrderId).HasColumnName("orderid");
                entity.Property(e => e.OrderDate).HasColumnName("orderdate");
                entity.Property(e => e.Username).HasColumnName("username");
                entity.Property(e => e.FirstName).HasColumnName("firstname");
                entity.Property(e => e.LastName).HasColumnName("lastname");
                entity.Property(e => e.Address).HasColumnName("address");
                entity.Property(e => e.City).HasColumnName("city");
                entity.Property(e => e.State).HasColumnName("state");
                entity.Property(e => e.PostalCode).HasColumnName("postalcode");
                entity.Property(e => e.Country).HasColumnName("country");
                entity.Property(e => e.Phone).HasColumnName("phone");
                entity.Property(e => e.Email).HasColumnName("email");
                entity.Property(e => e.Total).HasColumnName("total");

                // Preserve existing relationship
                entity.HasMany(o => o.OrderDetails)
                    .WithOne(od => od.Order)
                    .HasForeignKey(od => od.OrderId);
            });

            // -----------------------------------------------------------------------
            // OrderDetail: table + column mappings  (schema: gadgetsonline_dbo)
            // -----------------------------------------------------------------------
            modelBuilder.Entity<OrderDetail>(entity =>
            {
                entity.ToTable("orderdetails", "gadgetsonline_dbo");
                entity.Property(e => e.OrderDetailId).HasColumnName("orderdetailid");
                entity.Property(e => e.OrderId).HasColumnName("orderid");
                entity.Property(e => e.ProductId).HasColumnName("productid");
                entity.Property(e => e.Quantity).HasColumnName("quantity");
                entity.Property(e => e.UnitPrice).HasColumnName("unitprice");

                // Preserve existing relationship
                entity.HasOne(od => od.Product)
                    .WithMany()
                    .HasForeignKey(od => od.ProductId);
            });
        }
    }
}

using System;
using System.Configuration;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Data.Entity.ModelConfiguration.Conventions;
using System.IO;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using Npgsql;
using GadgetsOnline.Models;

namespace GadgetsOnline.Models
{
    /// <summary>
    /// EF6 PostgreSQL provider configuration for GadgetsOnlineEntities.
    /// Registers the Npgsql provider services and connection factory.
    /// </summary>
    public class GadgetsOnlineEntitiesPostgreSqlConfiguration : DbConfiguration
    {
        public GadgetsOnlineEntitiesPostgreSqlConfiguration()
        {
            SetProviderServices("Npgsql", NpgsqlServices.Instance);
            SetDefaultConnectionFactory(new NpgsqlConnectionFactory());
        }
    }

    [DbConfigurationType(typeof(GadgetsOnlineEntitiesPostgreSqlConfiguration))]
    public class GadgetsOnlineEntities : DbContext
    {
        /// <summary>
        /// Reads the "GadgetsOnlineEntities" connection string from appsettings.json
        /// at the project root. EF6 + Npgsql does not use web.config for connection
        /// strings, so we resolve the value here and pass it directly to the base
        /// DbContext constructor.
        /// </summary>
        private static string GetConnectionString()
        {
            // Walk up from the executing assembly location until we find appsettings.json
            var dir = AppDomain.CurrentDomain.BaseDirectory;
            string settingsPath = null;
            for (int i = 0; i < 6; i++)
            {
                var candidate = Path.Combine(dir, "appsettings.json");
                if (File.Exists(candidate))
                {
                    settingsPath = candidate;
                    break;
                }
                var parent = Directory.GetParent(dir);
                if (parent == null) break;
                dir = parent.FullName;
            }

            if (settingsPath != null)
            {
                var config = new ConfigurationBuilder()
                    .AddJsonFile(settingsPath, optional: false, reloadOnChange: false)
                    .Build();

                var cs = config.GetConnectionString("GadgetsOnlineEntities");
                if (!string.IsNullOrWhiteSpace(cs))
                    return cs;
            }

            throw new InvalidOperationException(
                "Connection string 'GadgetsOnlineEntities' was not found in appsettings.json. "
                + "Expected path: " + (settingsPath ?? "<appsettings.json not found>"));
        }

        // Default constructor — resolves connection string from appsettings.json
        public GadgetsOnlineEntities() : base(GetConnectionString())
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
        // DateTime compatibility: ensure every DateTime written to PostgreSQL
        // carries DateTimeKind.Utc (Npgsql rejects Unspecified/Local by default).
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
            // ---------------------------------------------------------------
            // Table & column mappings — schema: gadgetsonline_dbo
            // All names are lowercased for PostgreSQL compatibility.
            // ---------------------------------------------------------------

            // Product
            {
                var entity = modelBuilder.Entity<Product>();
                entity.ToTable("products", "gadgetsonline_dbo");
                entity.Property(e => e.ProductId).HasColumnName("productid");
                entity.Property(e => e.CategoryId).HasColumnName("categoryid");
                entity.Property(e => e.Name).HasColumnName("name");
                entity.Property(e => e.Price).HasColumnName("price");
                entity.Property(e => e.ProductArtUrl).HasColumnName("productarturl");
            }

            // Category
            {
                var entity = modelBuilder.Entity<Category>();
                entity.ToTable("categories", "gadgetsonline_dbo");
                entity.Property(e => e.CategoryId).HasColumnName("categoryid");
                entity.Property(e => e.Name).HasColumnName("name");
                entity.Property(e => e.Description).HasColumnName("description");

                // Relationship: Category → Products
                entity.HasMany(c => c.Products)
                    .WithRequired(p => p.Category)
                    .HasForeignKey(p => p.CategoryId);
            }

            // Cart
            {
                var entity = modelBuilder.Entity<Cart>();
                entity.ToTable("carts", "gadgetsonline_dbo");
                entity.Property(e => e.RecordId).HasColumnName("recordid");
                entity.Property(e => e.CartId).HasColumnName("cartid");
                entity.Property(e => e.ProductId).HasColumnName("productid");
                entity.Property(e => e.Count).HasColumnName("count");
                entity.Property(e => e.DateCreated).HasColumnName("datecreated");

                // Relationship: Cart → Product
                entity.HasRequired(c => c.Product)
                    .WithMany()
                    .HasForeignKey(c => c.ProductId);
            }

            // Order
            {
                var entity = modelBuilder.Entity<Order>();
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

                // Relationship: Order → OrderDetails
                entity.HasMany(o => o.OrderDetails)
                    .WithRequired(od => od.Order)
                    .HasForeignKey(od => od.OrderId);
            }

            // OrderDetail
            {
                var entity = modelBuilder.Entity<OrderDetail>();
                entity.ToTable("orderdetails", "gadgetsonline_dbo");
                entity.Property(e => e.OrderDetailId).HasColumnName("orderdetailid");
                entity.Property(e => e.OrderId).HasColumnName("orderid");
                entity.Property(e => e.ProductId).HasColumnName("productid");
                entity.Property(e => e.Quantity).HasColumnName("quantity");
                entity.Property(e => e.UnitPrice).HasColumnName("unitprice");

                // Relationship: OrderDetail → Product
                entity.HasRequired(od => od.Product)
                    .WithMany()
                    .HasForeignKey(od => od.ProductId);
            }
        }
    }
}

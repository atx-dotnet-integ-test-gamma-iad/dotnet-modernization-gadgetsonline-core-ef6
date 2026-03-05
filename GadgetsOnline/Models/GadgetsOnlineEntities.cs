using GadgetsOnline.Models;
using Npgsql;
using System;
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration.Conventions;
using System.Linq;
using System.Threading.Tasks;

namespace GadgetsOnline.Models
{
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
        // Default constructor using connection string name from config
        public GadgetsOnlineEntities() : base("name=GadgetsOnlineEntities")
        {
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

        public override int SaveChanges()
        {
            FixDateTimeKinds();
            return base.SaveChanges();
        }

        public override Task<int> SaveChangesAsync()
        {
            FixDateTimeKinds();
            return base.SaveChangesAsync();
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
            // --- Schema and column mappings: Product ---
            modelBuilder.Entity<Product>().ToTable("products", "public");
            modelBuilder.Entity<Product>().Property(e => e.ProductId).HasColumnName("product_id");
            modelBuilder.Entity<Product>().Property(e => e.CategoryId).HasColumnName("category_id");
            modelBuilder.Entity<Product>().Property(e => e.Name).HasColumnName("name");
            modelBuilder.Entity<Product>().Property(e => e.Price).HasColumnName("price");
            modelBuilder.Entity<Product>().Property(e => e.ProductArtUrl).HasColumnName("product_art_url");

            // --- Schema and column mappings: Category ---
            modelBuilder.Entity<Category>().ToTable("categories", "public");
            modelBuilder.Entity<Category>().Property(e => e.CategoryId).HasColumnName("category_id");
            modelBuilder.Entity<Category>().Property(e => e.Name).HasColumnName("name");
            modelBuilder.Entity<Category>().Property(e => e.Description).HasColumnName("description");

            // --- Schema and column mappings: Cart ---
            modelBuilder.Entity<Cart>().ToTable("carts", "public");
            modelBuilder.Entity<Cart>().Property(e => e.RecordId).HasColumnName("record_id");
            modelBuilder.Entity<Cart>().Property(e => e.CartId).HasColumnName("cart_id");
            modelBuilder.Entity<Cart>().Property(e => e.ProductId).HasColumnName("product_id");
            modelBuilder.Entity<Cart>().Property(e => e.Count).HasColumnName("count");
            modelBuilder.Entity<Cart>().Property(e => e.DateCreated).HasColumnName("date_created");

            // --- Schema and column mappings: Order ---
            modelBuilder.Entity<Order>().ToTable("orders", "public");
            modelBuilder.Entity<Order>().Property(e => e.OrderId).HasColumnName("order_id");
            modelBuilder.Entity<Order>().Property(e => e.OrderDate).HasColumnName("order_date");
            modelBuilder.Entity<Order>().Property(e => e.Username).HasColumnName("username");
            modelBuilder.Entity<Order>().Property(e => e.FirstName).HasColumnName("first_name");
            modelBuilder.Entity<Order>().Property(e => e.LastName).HasColumnName("last_name");
            modelBuilder.Entity<Order>().Property(e => e.Address).HasColumnName("address");
            modelBuilder.Entity<Order>().Property(e => e.City).HasColumnName("city");
            modelBuilder.Entity<Order>().Property(e => e.State).HasColumnName("state");
            modelBuilder.Entity<Order>().Property(e => e.PostalCode).HasColumnName("postal_code");
            modelBuilder.Entity<Order>().Property(e => e.Country).HasColumnName("country");
            modelBuilder.Entity<Order>().Property(e => e.Phone).HasColumnName("phone");
            modelBuilder.Entity<Order>().Property(e => e.Email).HasColumnName("email");
            modelBuilder.Entity<Order>().Property(e => e.Total).HasColumnName("total");

            // --- Schema and column mappings: OrderDetail ---
            modelBuilder.Entity<OrderDetail>().ToTable("orderdetails", "public");
            modelBuilder.Entity<OrderDetail>().Property(e => e.OrderDetailId).HasColumnName("order_detail_id");
            modelBuilder.Entity<OrderDetail>().Property(e => e.OrderId).HasColumnName("order_id");
            modelBuilder.Entity<OrderDetail>().Property(e => e.ProductId).HasColumnName("product_id");
            modelBuilder.Entity<OrderDetail>().Property(e => e.Quantity).HasColumnName("quantity");
            modelBuilder.Entity<OrderDetail>().Property(e => e.UnitPrice).HasColumnName("unit_price");

            // --- Relationships ---
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

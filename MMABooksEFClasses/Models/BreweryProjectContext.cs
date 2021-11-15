using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

#nullable disable

namespace BreweryProjectEFCore.Models
{
    public partial class BreweryProjectContext : DbContext
    {
        public BreweryProjectContext()
        {
        }

        public BreweryProjectContext(DbContextOptions<BreweryProjectContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Brew> Brews { get; set; }
        public virtual DbSet<Ingredient> Ingredients { get; set; }
        public virtual DbSet<Recipe> Recipes { get; set; }
        public virtual DbSet<Recipeingredient> Recipeingredients { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseMySQL("server=127.0.0.1;uid=root;pwd=thisPasswordIsNotSecure, please dont make bad practices make me get a virus;database=BrewerySystem");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Brew>(entity =>
            {
                entity.ToTable("brew");

                entity.HasIndex(e => e.RecipeId, "FK_Brew_Recipe");

                entity.Property(e => e.BrewId).HasColumnName("BrewID");

                entity.Property(e => e.RecipeId).HasColumnName("RecipeID");

                entity.Property(e => e.ScheduledDate).HasColumnType("date");

                entity.HasOne(d => d.Recipe)
                    .WithMany(p => p.Brews)
                    .HasForeignKey(d => d.RecipeId)
                    .HasConstraintName("FK_Brew_Recipe");
            });

            modelBuilder.Entity<Ingredient>(entity =>
            {
                entity.ToTable("ingredient");

                entity.Property(e => e.IngredientId).HasColumnName("IngredientID");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(40);
            });

            modelBuilder.Entity<Recipe>(entity =>
            {
                entity.ToTable("recipe");

                entity.Property(e => e.RecipeId).HasColumnName("RecipeID");

                entity.Property(e => e.Abv)
                    .HasColumnType("decimal(10,4)")
                    .HasColumnName("ABV");

                entity.Property(e => e.Active)
                    .IsRequired()
                    .HasDefaultValueSql("'1'");

                entity.Property(e => e.Ibu)
                    .HasColumnType("decimal(10,4)")
                    .HasColumnName("IBU");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.Style)
                    .IsRequired()
                    .HasMaxLength(20);
            });

            modelBuilder.Entity<Recipeingredient>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("recipeingredient");

                entity.HasIndex(e => e.IngredientId, "FK_RecipeIngredient_Ingredient");

                entity.HasIndex(e => e.RecipeId, "FK_RecipeIngredient_Recipe");

                entity.Property(e => e.IngredientId).HasColumnName("IngredientID");

                entity.Property(e => e.RecipeId).HasColumnName("RecipeID");

                entity.HasOne(d => d.Ingredient)
                    .WithMany()
                    .HasForeignKey(d => d.IngredientId)
                    .HasConstraintName("FK_RecipeIngredient_Ingredient");

                entity.HasOne(d => d.Recipe)
                    .WithMany()
                    .HasForeignKey(d => d.RecipeId)
                    .HasConstraintName("FK_RecipeIngredient_Recipe");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}

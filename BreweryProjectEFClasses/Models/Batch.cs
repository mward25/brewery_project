using System;
using System.Collections.Generic;

#nullable disable

namespace BreweryProjectEFCore.Models
{
    public partial class Batch
    {
        public Batch()
        {
            BatchContainers = new HashSet<BatchContainer>();
            IngredientInventorySubtractions = new HashSet<IngredientInventorySubtraction>();
            InventoryTransactions = new HashSet<InventoryTransaction>();
            Products = new HashSet<Product>();
        }

        public int BatchId { get; set; }
        public int RecipeId { get; set; }
        public int EquipmentId { get; set; }
        public double Volume { get; set; }
        public DateTime? ScheduledStartDate { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EstimatedFinishDate { get; set; }
        public DateTime? FinishDate { get; set; }
        public decimal? UnitCost { get; set; }
        public string Notes { get; set; }
        public string TasteNotes { get; set; }
        public double? TasteRating { get; set; }
        public double? Og { get; set; }
        public double? Fg { get; set; }
        public double? Carbonation { get; set; }
        public int? FermentationStages { get; set; }
        public double? PrimaryAge { get; set; }
        public double? PrimaryTemp { get; set; }
        public double? SecondaryAge { get; set; }
        public double? SecondaryTemp { get; set; }
        public double? TertiaryAge { get; set; }
        public double? Age { get; set; }
        public double? Temp { get; set; }
        public double? Ibu { get; set; }
        public string IbuMethod { get; set; }
        public double? Abv { get; set; }
        public double? ActualEfficiency { get; set; }
        public double? Calories { get; set; }
        public string CarbonationUsed { get; set; }
        public byte? ForcedCarbonation { get; set; }
        public double? KegPrimingFactor { get; set; }
        public double? CarbonationTemp { get; set; }

        public virtual Equipment Equipment { get; set; }
        public virtual Recipe Recipe { get; set; }
        public virtual ICollection<BatchContainer> BatchContainers { get; set; }
        public virtual ICollection<IngredientInventorySubtraction> IngredientInventorySubtractions { get; set; }
        public virtual ICollection<InventoryTransaction> InventoryTransactions { get; set; }
        public virtual ICollection<Product> Products { get; set; }
    }
}

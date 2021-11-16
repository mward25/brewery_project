using System;
using System.Collections.Generic;

#nullable disable

namespace BreweryProjectEFCore.Models
{
    public partial class Fermentable
    {
        public int IngredientId { get; set; }
        public int? FermentableTypeId { get; set; }
        public double? Color { get; set; }
        public double? Yield { get; set; }
        public string Origin { get; set; }
        public double? CoarseFineDiff { get; set; }
        public double? Moisture { get; set; }
        public double? DiastaticPower { get; set; }
        public double? Protein { get; set; }
        public double? MaxInBatch { get; set; }
        public byte? RecommendMash { get; set; }
        public byte? AddAfterBoil { get; set; }
        public double? IbuGalPerLb { get; set; }
        public double? Potential { get; set; }

        public virtual FermentableType FermentableType { get; set; }
        public virtual Ingredient Ingredient { get; set; }
    }
}

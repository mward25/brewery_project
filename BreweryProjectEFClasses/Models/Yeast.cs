using System;
using System.Collections.Generic;

#nullable disable

namespace BreweryProjectEFCore.Models
{
    public partial class Yeast
    {
        public int IngredientId { get; set; }
        public string ProductId { get; set; }
        public double? MinTemp { get; set; }
        public double? MaxTemp { get; set; }
        public string Form { get; set; }
        public string Laboratory { get; set; }
        public string Flocculation { get; set; }
        public double? Attenuation { get; set; }
        public int? MaxReuse { get; set; }
        public byte? AddToSecondary { get; set; }
        public string Type { get; set; }
        public string BestFor { get; set; }

        public virtual Ingredient Ingredient { get; set; }
    }
}

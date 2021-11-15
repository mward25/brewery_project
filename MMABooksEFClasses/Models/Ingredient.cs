using System;
using System.Collections.Generic;

#nullable disable

namespace BreweryProjectEFCore.Models
{
    public partial class Ingredient
    {
        public int IngredientId { get; set; }
        public string Name { get; set; }
        public int Quantity { get; set; }
    }
}

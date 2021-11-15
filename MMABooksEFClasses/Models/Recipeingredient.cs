using System;
using System.Collections.Generic;

#nullable disable

namespace BreweryProjectEFCore.Models
{
    public partial class Recipeingredient
    {
        public int RecipeId { get; set; }
        public int IngredientId { get; set; }
        public int AmountInRecipe { get; set; }

        public virtual Ingredient Ingredient { get; set; }
        public virtual Recipe Recipe { get; set; }
    }
}

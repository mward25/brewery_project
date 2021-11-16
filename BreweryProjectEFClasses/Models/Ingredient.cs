using System;
using System.Collections.Generic;

#nullable disable

namespace BreweryProjectEFCore.Models
{
    public partial class Ingredient
    {
        public Ingredient()
        {
            IngredientInventoryAdditions = new HashSet<IngredientInventoryAddition>();
            IngredientInventorySubtractions = new HashSet<IngredientInventorySubtraction>();
            IngredientSubstituteIngredients = new HashSet<IngredientSubstitute>();
            IngredientSubstituteSubstituteIngredients = new HashSet<IngredientSubstitute>();
            IngredientUsedIns = new HashSet<IngredientUsedIn>();
            RecipeIngredients = new HashSet<RecipeIngredient>();
        }

        public int IngredientId { get; set; }
        public string Name { get; set; }
        public int? Version { get; set; }
        public int IngredientTypeId { get; set; }
        public double OnHandQuantity { get; set; }
        public int UnitTypeId { get; set; }
        public decimal UnitCost { get; set; }
        public double ReorderPoint { get; set; }
        public string Notes { get; set; }

        public virtual IngredientType IngredientType { get; set; }
        public virtual UnitType UnitType { get; set; }
        public virtual Adjunct Adjunct { get; set; }
        public virtual Fermentable Fermentable { get; set; }
        public virtual Hop Hop { get; set; }
        public virtual Yeast Yeast { get; set; }
        public virtual ICollection<IngredientInventoryAddition> IngredientInventoryAdditions { get; set; }
        public virtual ICollection<IngredientInventorySubtraction> IngredientInventorySubtractions { get; set; }
        public virtual ICollection<IngredientSubstitute> IngredientSubstituteIngredients { get; set; }
        public virtual ICollection<IngredientSubstitute> IngredientSubstituteSubstituteIngredients { get; set; }
        public virtual ICollection<IngredientUsedIn> IngredientUsedIns { get; set; }
        public virtual ICollection<RecipeIngredient> RecipeIngredients { get; set; }
    }
}

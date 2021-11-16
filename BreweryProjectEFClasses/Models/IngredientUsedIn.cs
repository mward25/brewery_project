using System;
using System.Collections.Generic;

#nullable disable

namespace BreweryProjectEFCore.Models
{
    public partial class IngredientUsedIn
    {
        public int IngredientId { get; set; }
        public int StyleId { get; set; }

        public virtual Ingredient Ingredient { get; set; }
        public virtual Style Style { get; set; }
    }
}

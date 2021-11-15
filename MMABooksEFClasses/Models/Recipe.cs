using System;
using System.Collections.Generic;

#nullable disable

namespace BreweryProjectEFCore.Models
{
    public partial class Recipe
    {
        public Recipe()
        {
            Brews = new HashSet<Brew>();
        }

        public int RecipeId { get; set; }
        public string Name { get; set; }
        public string Style { get; set; }
        public int Version { get; set; }
        public decimal Ibu { get; set; }
        public decimal Abv { get; set; }
        public bool? Active { get; set; }

        public virtual ICollection<Brew> Brews { get; set; }
    }
}

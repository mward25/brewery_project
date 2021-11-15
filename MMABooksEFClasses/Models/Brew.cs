using System;
using System.Collections.Generic;

#nullable disable

namespace BreweryProjectEFCore.Models
{
    public partial class Brew
    {
        public int BrewId { get; set; }
        public int RecipeId { get; set; }
        public DateTime ScheduledDate { get; set; }
        public bool Done { get; set; }

        public virtual Recipe Recipe { get; set; }
    }
}

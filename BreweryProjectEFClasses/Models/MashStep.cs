using System;
using System.Collections.Generic;

#nullable disable

namespace BreweryProjectEFCore.Models
{
    public partial class MashStep
    {
        public int MashStepId { get; set; }
        public int MashId { get; set; }
        public string Name { get; set; }
        public int? Version { get; set; }
        public string Type { get; set; }
        public double? InfuseAmount { get; set; }
        public double? StepTime { get; set; }
        public double? StepTemp { get; set; }
        public double? RampTime { get; set; }
        public double? EndTemp { get; set; }
        public string Description { get; set; }
        public string WaterGrainRatio { get; set; }
        public string DecoctionAmount { get; set; }
        public string InfuseTemp { get; set; }

        public virtual Mash Mash { get; set; }
    }
}

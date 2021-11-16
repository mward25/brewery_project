using System.Collections.Generic;
using System.Linq;
using System;

using NUnit.Framework;
using BreweryProjectEFCore.Models;
using Microsoft.EntityFrameworkCore;

namespace BrewProjectTests 
{
    [TestFixture]
    public class BatchTest 
    {
        BreweryProjectContext dbContext;
        Batch theBatch;
        List<Batch> batches;

        [SetUp]
        public void Setup()
        {
            dbContext = new BreweryProjectContext();

            Batch testBatch = new Batch();
        //public int RecipeId { get; set; }
            testBatch.RecipeId = 1;
        //public int EquipmentId { get; set; }
            testBatch.EquipmentId = 1;
        //public double Volume { get; set; }
            testBatch.Volume = 10;
        //public new DateTime? ScheduledStartDate { get; set; }
            testBatch.ScheduledStartDate = new DateTime(2021, 10, 30);
        //public new DateTime? StartDate { get; set; }
            testBatch.StartDate = new DateTime(2021, 10, 19);
        //public new DateTime? EstimatedFinishDate { get; set; }
            testBatch.EstimatedFinishDate = new DateTime(2021, 11, 1);
        //public new DateTime? FinishDate { get; set; }
            testBatch.FinishDate = new DateTime(2021, 11, 1);
        //public decimal? UnitCost { get; set; }
            testBatch.UnitCost = 10m;
        //public string Notes { get; set; }
            testBatch.Notes = "These are some helpful notes!!!";
        //public string TasteNotes { get; set; }
            testBatch.TasteNotes = "prety good";
        //public double? TasteRating { get; set; }
            testBatch.TasteRating = 2.5;
        //public double? Og { get; set; }
        testBatch.Og = 32;
        //public double? Fg { get; set; }
        testBatch.Fg = 21;
        //public double? Carbonation { get; set; }
        testBatch.Carbonation = 32.12;
        //public int? FermentationStages { get; set; }
        testBatch.FermentationStages = 122;
        //public double? PrimaryAge { get; set; }
        testBatch.PrimaryAge = 12;
        //public double? PrimaryTemp { get; set; }
        testBatch.PrimaryTemp = 12.12;
        //public double? SecondaryAge { get; set; }
        testBatch.SecondaryAge = 12.12;
        //public double? SecondaryTemp { get; set; }
        testBatch.SecondaryTemp = 90.21;
        //public double? TertiaryAge { get; set; }
        testBatch.TertiaryAge = 12.21;
        //public double? Age { get; set; }
        testBatch.Age = 90;
        //public double? Temp { get; set; }
        testBatch.Temp = 10;
        //public double? Ibu { get; set; }
        testBatch.Ibu = 10.10;
        //public string IbuMethod { get; set; }
        testBatch.IbuMethod = "toothpick";
        //public double? Abv { get; set; }
        testBatch.Abv = 21;
        //public double? ActualEfficiency { get; set; }
        testBatch.ActualEfficiency = 90;
        //public double? Calories { get; set; }
        testBatch.Calories = 1000;
        //public string CarbonationUsed { get; set; }
        testBatch.CarbonationUsed = "alot";
        //public byte? ForcedCarbonation { get; set; }
        testBatch.ForcedCarbonation = 25;
        //public double? KegPrimingFactor { get; set; }
        testBatch.KegPrimingFactor = 32.12;
        //public double? CarbonationTemp { get; set; }
        testBatch.CarbonationTemp = 33.12;

        dbContext.Add(testBatch);
        dbContext.SaveChanges();
        theBatch = testBatch;
            //dbContext.Database.ExecuteSqlRaw("CALL usp_testingResetData()");
        }

        [TearDown]
        public void TearDown()
        {
                List<Batch> testBatches = dbContext.Batches.ToList();
                Console.WriteLine("running TearDown function in BatchTests");
                PrintAll(testBatches);
                foreach (Batch batchInBatches in testBatches)
                {
                    dbContext.Remove(batchInBatches);
                }

                dbContext.SaveChanges();
                Console.WriteLine("stopping TearDown function in BatchTests");
        }



        [Test]
        public void GetAllTest()
        {
            batches = dbContext.Batches.OrderBy(theBatch => theBatch.BatchId).ToList();
            Assert.AreEqual(1, batches.Count);
            //Assert.AreEqual("A4CS", batches[0].ProductCode);
            //PrintAll(batches);
        }

        [Test]
        public void testTesting()
        {
                Assert.AreEqual(10, 10);
        }

        [Test]
        public void GetByPrimaryKeyTest()
        {
            theBatch = dbContext.Batches.Find(theBatch.BatchId);
            Assert.IsNotNull(theBatch);
            Assert.AreEqual(10.10, theBatch.Ibu);
        }

        [Test]
        public void GetUsingWhere()
        {
            batches = dbContext.Batches.Where((theBatch => theBatch.Ibu == 10.10)).ToList();
            Assert.IsNotNull(batches);
            foreach (Batch item in batches)
            {
                Assert.AreEqual(10.10, item.Ibu);
            }

        }

        [Test]
        public void DeleteTest()
        {
            int theBatchId = theBatch.BatchId;
            theBatch = dbContext.Batches.Find(theBatch.BatchId);
            dbContext.Batches.Remove(theBatch);
            dbContext.SaveChanges();
            Assert.IsNull(dbContext.Batches.Find(theBatchId));
        }

        [Test]
        public void CreateTest()
        {
            // Not necesary, A batch is created in Setup function
        }

        [Test]
        public void UpdateTest()
        {
        
                int theBatchId = theBatch.BatchId;
                theBatch = dbContext.Batches.Find(theBatch.BatchId);
                string oBatchNotes = theBatch.Notes;
                double? oIbu = theBatch.Ibu;

                theBatch.Notes = "ha ha, I changed the Notes";
                theBatch.Ibu = 100.0;
                string nNotes = theBatch.Notes;
                double? nIbu = theBatch.Ibu;
                dbContext.Batches.Update(theBatch);
                dbContext.SaveChanges();
                
                
                theBatch = dbContext.Batches.Find(theBatchId);
                
                Assert.AreNotEqual(theBatch.Notes, oBatchNotes);
                Assert.AreNotEqual(theBatch.Ibu, oIbu);
                Assert.AreEqual(theBatch.Notes, nNotes);
                Assert.AreEqual(theBatch.Ibu, nIbu);
        }
        
        
        public void PrintAll(List<Batch> batches)
        {
            foreach (Batch theBatch in batches)
            {
                Console.WriteLine("Name: {0}, Notes: {1}", theBatch.RecipeId.ToString(), theBatch.Notes);
            }
        }
    }
}

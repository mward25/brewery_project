
using System.Collections.Generic;
using System.Linq;
using System;

using NUnit.Framework;
using BreweryProjectEFCore.Models;
using Microsoft.EntityFrameworkCore;

namespace BreweryProjectTests 
{
    [TestFixture]
    public class BrewTests 
    {
        
        //MMABooksContext dbContext;
        BreweryProjectContext dbContext;
        //State s;
        Brew theBrew;
        //List<State> states;
        List<Brew> brews;

        [SetUp]
        public void Setup()
        {
            dbContext = new BreweryProjectContext();
            try 
            {
                dbContext.Database.ExecuteSqlRaw("CALL usp_testing_reset_data()");
            }
            catch (Exception e)
            {
                Console.WriteLine("you should probobly fix the exception in your code miles!!!");
            }
        }

        [Test]
        public void testTest()
        {
            int a = 5;
            Assert.AreEqual(5, a);
            Console.WriteLine("if this test fails, it means something is fundumentaly wrong with nUnit.");
        }

        [Test]
        public void GetAllTest()
        {
            brews = dbContext.Brews.OrderBy(theBrew => theBrew.BrewId).ToList();
            Assert.AreEqual(2, brews.Count);
            Assert.AreEqual("12/21/2021 12:00:00 AM", brews[0].ScheduledDate.ToString());
            PrintAll(brews);
        }

        [Test]
        public void GetByPrimaryKeyTest()
        {
            theBrew = dbContext.Brews.Find(1);
            Assert.IsNotNull(theBrew);
            Console.WriteLine(theBrew);
        }

        [Test]
        public void GetUsingWhere()
        {
            // current version generates a null processing error StartsWith can't operate on a nullable value
            brews = dbContext.Brews.Where(theBrew => theBrew.BrewId == 2).OrderBy(theBrew => theBrew.Done).ToList();
            Assert.AreEqual(1, brews.Count);
            Assert.AreEqual(false, brews[0].Done);
            PrintAll(brews);
        }

        ////[Test]
        ////public void GetWithCustomersTest()
        ////{
        ////    theBrew = dbContext.Brews.Include("Customers").Where(theBrew => theBrew.StateCode == "OR").SingleOrDefault();
        ////    Assert.IsNotNull(theBrew);
        ////    Assert.AreEqual("Oregon", theBrew.StateBrewId);
        ////    Assert.AreEqual(5, theBrew.Customers.Count);
        ////    Console.WriteLine(theBrew);
        ////}

        [Test]
        public void DeleteTest()
        {
            theBrew = dbContext.Brews.Find(2);
            dbContext.Brews.Remove(theBrew);
            dbContext.SaveChanges();
            Assert.IsNull(dbContext.Brews.Find(2));
        }

        [Test]
        public void CreateTest()
        {
            theBrew = new Brew();
            theBrew.RecipeId = ((dbContext.Recipes.Where(theRecipe => theRecipe.Name == "densier").ToList())[0]).RecipeId;
            theBrew.ScheduledDate = new DateTime(2022, 12, 20);
            dbContext.Add(theBrew);
            dbContext.SaveChanges();
            
            int theBrewId = theBrew.BrewId;
            DateTime theDate = theBrew.ScheduledDate;

            theBrew = dbContext.Brews.Find(theBrewId);
            Assert.AreEqual(theBrew.BrewId, theBrewId);
            Assert.AreEqual(theBrew.ScheduledDate, theDate);
        }

        [Test]
        public void UpdateTest()
        {
            theBrew = dbContext.Brews.Find(2);
            int oBrewId = theBrew.BrewId;
            DateTime oldDate = theBrew.ScheduledDate;
            
            DateTime nDate = new DateTime(2022, 10, 2);
            theBrew.ScheduledDate = nDate;

            dbContext.Update(theBrew);
            dbContext.SaveChanges();
            
            
            theBrew = dbContext.Brews.Find(2);
            
            Assert.AreNotEqual(theBrew.ScheduledDate, oldDate);
            Assert.AreEqual(theBrew.ScheduledDate, nDate);
        }

        public void PrintAll(List<Brew> brews)
        {
            foreach (Brew theBrew in brews)
            {
                Console.WriteLine(theBrew.BrewId);
            }
        }
        
    }
}

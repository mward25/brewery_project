using System.Collections.Generic;
using System.Linq;
using System;

using NUnit.Framework;
using BreweryProjectEFCore.Models;
using Microsoft.EntityFrameworkCore;

namespace BreweryProjectTests 
{
    [TestFixture]
    public class RecipeTests 
    {
        
        //MMABooksContext dbContext;
        BreweryProjectContext dbContext;
        //State s;
        Recipe theRecipe;
        //List<State> states;
        List<Recipe> recipes;

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

        //[Test]
        //public void GetAllTest()
        //{
        //    recipes = dbContext.Brews.OrderBy(theRecipe => theRecipe.BrewId).ToList();
        //    Assert.AreEqual(2, recipes.Count);
        //    Assert.AreEqual("12/21/2021 12:00:00 AM", recipes[0].ScheduledDate.ToString());
        //    PrintAll(recipes);
        //}

        //[Test]
        //public void GetByPrimaryKeyTest()
        //{
        //    theRecipe = dbContext.Brews.Find(1);
        //    Assert.IsNotNull(theRecipe);
        //    Console.WriteLine(theRecipe);
        //}

        //[Test]
        //public void GetUsingWhere()
        //{
        //    // current version generates a null processing error StartsWith can't operate on a nullable value
        //    recipes = dbContext.Brews.Where(theRecipe => theRecipe.BrewId == 2).OrderBy(theRecipe => theRecipe.Done).ToList();
        //    Assert.AreEqual(1, recipes.Count);
        //    Assert.AreEqual(false, recipes[0].Done);
        //    PrintAll(recipes);
        //}

        //////[Test]
        //////public void GetWithCustomersTest()
        //////{
        //////    theRecipe = dbContext.Brews.Include("Customers").Where(theRecipe => theRecipe.StateCode == "OR").SingleOrDefault();
        //////    Assert.IsNotNull(theRecipe);
        //////    Assert.AreEqual("Oregon", theRecipe.StateBrewId);
        //////    Assert.AreEqual(5, theRecipe.Customers.Count);
        //////    Console.WriteLine(theRecipe);
        //////}

        //[Test]
        //public void DeleteTest()
        //{
        //    theRecipe = dbContext.Brews.Find(2);
        //    dbContext.Brews.Remove(theRecipe);
        //    dbContext.SaveChanges();
        //    Assert.IsNull(dbContext.Brews.Find(2));
        //}

        //[Test]
        //public void CreateTest()
        //{
        //    theRecipe = new Brew();
        //    theRecipe.RecipeId = ((dbContext.Recipes.Where(theRecipe => theRecipe.Name == "densier").ToList())[0]).RecipeId;
        //    theRecipe.ScheduledDate = new DateTime(2022, 12, 20);
        //    dbContext.Add(theRecipe);
        //    dbContext.SaveChanges();
        //    
        //    int theBrewId = theRecipe.BrewId;
        //    DateTime theDate = theRecipe.ScheduledDate;

        //    theRecipe = dbContext.Brews.Find(theBrewId);
        //    Assert.AreEqual(theRecipe.BrewId, theBrewId);
        //    Assert.AreEqual(theRecipe.ScheduledDate, theDate);
        //}

        //[Test]
        //public void UpdateTest()
        //{
        //    theRecipe = dbContext.Brews.Find(2);
        //    int oBrewId = theRecipe.BrewId;
        //    DateTime oldDate = theRecipe.ScheduledDate;
        //    
        //    DateTime nDate = new DateTime(2022, 10, 2);
        //    theRecipe.ScheduledDate = nDate;

        //    dbContext.Update(theRecipe);
        //    dbContext.SaveChanges();
        //    
        //    
        //    theRecipe = dbContext.Brews.Find(2);
        //    
        //    Assert.AreNotEqual(theRecipe.ScheduledDate, oldDate);
        //    Assert.AreEqual(theRecipe.ScheduledDate, nDate);
        //}

        //public void PrintAll(List<Brew> recipes)
        //{
        //    foreach (Brew theRecipe in recipes)
        //    {
        //        Console.WriteLine(theBrew.BrewId);
        //    }
        //}
        
    }
}

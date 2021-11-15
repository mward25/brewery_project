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

        [Test]
        public void GetAllTest()
        {
            recipes = dbContext.Recipes.OrderBy(theRecipe => theRecipe.Name).ToList();
            Assert.AreEqual(2, recipes.Count);
            Assert.AreEqual("densier", recipes[0].Name);
            PrintAll(recipes);
        }

        [Test]
        public void GetByPrimaryKeyTest()
        {
            theRecipe = dbContext.Recipes.Find(1);
            Assert.IsNotNull(theRecipe);
            Console.WriteLine(theRecipe);
        }

        [Test]
        public void GetUsingWhere()
        {
            // current version generates a null processing error StartsWith can't operate on a nullable value
            recipes = dbContext.Recipes.Where(theRecipe => theRecipe.RecipeId == 2).OrderBy(theRecipe => theRecipe.Name).ToList();
            Assert.AreEqual(1, recipes.Count);
            Assert.AreEqual("densier", recipes[0].Name);
            PrintAll(recipes);
        }

        // Aren't all the //////'s nice
        //////[Test]
        //////public void GetWithCustomersTest()
        //////{
        //////    theRecipe = dbContext.Recipes.Include("Customers").Where(theRecipe => theRecipe.StateCode == "OR").SingleOrDefault();
        //////    Assert.IsNotNull(theRecipe);
        //////    Assert.AreEqual("Oregon", theRecipe.StateName);
        //////    Assert.AreEqual(5, theRecipe.Customers.Count);
        //////    Console.WriteLine(theRecipe);
        //////}

        [Test]
        public void DeleteTest()
        {
            theRecipe = dbContext.Recipes.Find(2);
            dbContext.Recipes.Remove(theRecipe);
            dbContext.SaveChanges();
            Assert.IsNull(dbContext.Recipes.Find(2));
        }

        [Test]
        public void CreateTest()
        {
            theRecipe = new Recipe();
            theRecipe.Name = "fuzzy beer"; 
            theRecipe.Style = "fuzzy :)";
            theRecipe.Version = 1;
            theRecipe.Ibu = 20m;
            theRecipe.Abv = 10m;
            theRecipe.Active = true;
            dbContext.Add(theRecipe);
            dbContext.SaveChanges();
            
            string theName = theRecipe.Name;
            string theStyle = theRecipe.Style;
            decimal theIbu = theRecipe.Ibu;

            theRecipe = dbContext.Recipes.Find(theRecipe.RecipeId);
            Assert.AreEqual(theRecipe.Name, theName);
            Assert.AreEqual(theRecipe.Style, theStyle);
            Assert.AreEqual(theRecipe.Ibu, theIbu);
        }

        [Test]
        public void UpdateTest()
        {
            theRecipe = dbContext.Recipes.Find(2);
            string oName = theRecipe.Name;
            
            theRecipe.Name = "BAD_BEER_DONT_BUY";
            string nName = theRecipe.Name;

            dbContext.Update(theRecipe);
            dbContext.SaveChanges();
            
            
            theRecipe = dbContext.Recipes.Find(2);
            
            Assert.AreNotEqual(theRecipe.Name, oName);
            Assert.AreEqual(theRecipe.Name, nName);
        }

        public void PrintAll(List<Recipe> recipes)
        {
            foreach (Recipe theRecipe in recipes)
            {
                Console.WriteLine(theRecipe.Name);
            }
        }
        
    }
}

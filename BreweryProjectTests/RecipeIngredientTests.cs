using System.Collections.Generic;
using System.Linq;
using System;

using NUnit.Framework;
using BreweryProjectEFCore.Models;
using Microsoft.EntityFrameworkCore;

namespace BreweryProjectTests 
{
    [TestFixture]
    public class RecipeIngredientTests 
    {
        
        //MMABooksContext dbContext;
        BreweryProjectContext dbContext;
        //State s;
        Recipeingredient theRecipeIngredient;
        //List<State> states;
        List<Recipeingredient> recipeIngredients;

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
        //    recipeIngredients = dbContext.Recipes.OrderBy(theRecipeIngredient => theRecipeIngredient.Name).ToList();
        //    Assert.AreEqual(2, recipeIngredients.Count);
        //    Assert.AreEqual("densier", recipeIngredients[0].Name);
        //    PrintAll(recipeIngredients);
        //}

        //[Test]
        //public void GetByPrimaryKeyTest()
        //{
        //    theRecipeIngredient = dbContext.Recipes.Find(1);
        //    Assert.IsNotNull(theRecipeIngredient);
        //    Console.WriteLine(theRecipeIngredient);
        //}

        //[Test]
        //public void GetUsingWhere()
        //{
        //    // current version generates a null processing error StartsWith can't operate on a nullable value
        //    recipeIngredients = dbContext.Recipes.Where(theRecipeIngredient => theRecipeIngredient.RecipeId == 2).OrderBy(theRecipeIngredient => theRecipeIngredient.Name).ToList();
        //    Assert.AreEqual(1, recipeIngredients.Count);
        //    Assert.AreEqual("densier", recipeIngredients[0].Name);
        //    PrintAll(recipeIngredients);
        //}

        //// Aren't all the //////'s nice
        ////////[Test]
        ////////public void GetWithCustomersTest()
        ////////{
        ////////    theRecipeIngredient = dbContext.Recipes.Include("Customers").Where(theRecipeIngredient => theRecipeIngredient.StateCode == "OR").SingleOrDefault();
        ////////    Assert.IsNotNull(theRecipeIngredient);
        ////////    Assert.AreEqual("Oregon", theRecipeIngredient.StateName);
        ////////    Assert.AreEqual(5, theRecipeIngredient.Customers.Count);
        ////////    Console.WriteLine(theRecipeIngredient);
        ////////}

        //[Test]
        //public void DeleteTest()
        //{
        //    theRecipeIngredient = dbContext.Recipes.Find(2);
        //    dbContext.Recipes.Remove(theRecipeIngredient);
        //    dbContext.SaveChanges();
        //    Assert.IsNull(dbContext.Recipes.Find(2));
        //}

        //[Test]
        //public void CreateTest()
        //{
        //    theRecipeIngredient = new Recipeingredient();
        //    theRecipeIngredient.Name = "fuzzy beer"; 
        //    theRecipeIngredient.Style = "fuzzy :)";
        //    theRecipeIngredient.Version = 1;
        //    theRecipeIngredient.Ibu = 20m;
        //    theRecipeIngredient.Abv = 10m;
        //    theRecipeIngredient.Active = true;
        //    dbContext.Add(theRecipeIngredient);
        //    dbContext.SaveChanges();
        //    
        //    string theName = theRecipeIngredient.Name;
        //    string theStyle = theRecipeIngredient.Style;
        //    decimal theIbu = theRecipeIngredient.Ibu;

        //    theRecipeIngredient = dbContext.Recipes.Find(theRecipeIngredient.RecipeId);
        //    Assert.AreEqual(theRecipeIngredient.Name, theName);
        //    Assert.AreEqual(theRecipeIngredient.Style, theStyle);
        //    Assert.AreEqual(theRecipeIngredient.Ibu, theIbu);
        //}

        //[Test]
        //public void UpdateTest()
        //{
        //    theRecipeIngredient = dbContext.Recipes.Find(2);
        //    string oName = theRecipeIngredient.Name;
        //    
        //    theRecipeIngredient.Name = "BAD_BEER_DONT_BUY";
        //    string nName = theRecipeIngredient.Name;

        //    dbContext.Update(theRecipeIngredient);
        //    dbContext.SaveChanges();
        //    
        //    
        //    theRecipeIngredient = dbContext.Recipes.Find(2);
        //    
        //    Assert.AreNotEqual(theRecipeIngredient.Name, oName);
        //    Assert.AreEqual(theRecipeIngredient.Name, nName);
        //}

        //public void PrintAll(List<Recipeingredient> recipeIngredients)
        //{
        //    foreach (Recipeingredient theRecipeIngredient in recipeIngredients)
        //    {
        //        Console.WriteLine(theRecipeIngredient.Name);
        //    }
        //}
        
    }
}

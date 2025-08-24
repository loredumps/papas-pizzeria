class roygame.models.customers.Customer9 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 9;
   var customername = "Maggie";
   var orders = [[],[[[0],[0],[0],[4,0,0,1,1],[0],[6,1,1,0,0],[0],2,4]]];
   function Customer9(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 9 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}

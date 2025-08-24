class roygame.models.customers.Customer18 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 18;
   var customername = "Mitch";
   var orders = [[],[[[4,1,1,0,0],[0],[0],[0],[0],[2,1,0,0,0],[4,1,1,0,0],2,4]]];
   function Customer18(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 18 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}

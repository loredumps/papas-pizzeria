class roygame.models.customers.Customer21 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 21;
   var customername = "Cecilia";
   var orders = [[],[[[0],[0],[6,1,1,1,0],[3,0,1,1,1],[3,1,1,0,1],[0],[0],2,8]]];
   function Customer21(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 21 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}

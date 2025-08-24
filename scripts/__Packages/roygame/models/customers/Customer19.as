class roygame.models.customers.Customer19 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 19;
   var customername = "Prudence";
   var orders = [[],[[[0],[0],[5,1,0,0,0],[0],[3,0,1,0,0],[0],[0],2,6]]];
   function Customer19(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 19 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}

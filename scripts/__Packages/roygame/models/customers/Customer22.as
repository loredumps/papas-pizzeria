class roygame.models.customers.Customer22 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 22;
   var customername = "Mandi";
   var orders = [[],[[[4,1,1,0,0],[0],[6,1,0,1,1],[0],[0],[0],[0],4,8]]];
   function Customer22(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 22 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}

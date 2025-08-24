class roygame.models.customers.Customer13 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 13;
   var customername = "Mindy";
   var orders = [[],[[[0],[0],[4,1,0,0,0],[0],[0],[0],[6,1,1,0,0],5,8]]];
   function Customer13(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 13 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}

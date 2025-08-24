class roygame.models.customers.Customer16 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 16;
   var customername = "Robby";
   var orders = [[],[[[0],[0],[6,0,1,1,1],[6,0,0,1,1],[0],[0],[0],4,6]]];
   function Customer16(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 16 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}

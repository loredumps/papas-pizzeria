class roygame.models.customers.Customer24 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 24;
   var customername = "Olga";
   var orders = [[],[[[0],[6,1,1,1,0],[4,0,0,1,0],[2,0,0,1,0],[0],[0],[0],6,4]]];
   function Customer24(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 24 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}

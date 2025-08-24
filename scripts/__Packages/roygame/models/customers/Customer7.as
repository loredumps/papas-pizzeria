class roygame.models.customers.Customer7 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 7;
   var customername = "Big Pauly";
   var orders = [[],[[[0],[4,1,1,0,0],[0],[0],[4,0,0,1,1],[0],[0],3,8]]];
   function Customer7(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 7 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}

class roygame.models.customers.Customer6 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 6;
   var customername = "Timm";
   var orders = [[],[[[0],[0],[0],[4,0,0,1,1],[0],[0],[0],4,6]]];
   function Customer6(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 6 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}

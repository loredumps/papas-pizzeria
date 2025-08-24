class roygame.models.customers.Customer35 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 35;
   var customername = "SargeFan!";
   var orders = [[],[[[0],[0],[0],[0],[12,1,1,1,1],[0],[0],5,6]]];
   function Customer35(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 35 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}


import 'package:anbu_stores_bills/models/Customer.dart';

List<Customer> sort(List<Customer> customers){
  customers.sort((a,b){
    if(a.balance > b.balance) return 1;
    else return 0;

  });
  customers.forEach((element) { print(element.balance);});
  return customers;
}
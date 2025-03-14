import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pawrentingreborn/common/widgets/appBar/appBar2.dart';
import 'package:pawrentingreborn/features/home/controllers/CartController.dart';
import 'package:pawrentingreborn/features/home/controllers/DeliveryController.dart';
import 'package:pawrentingreborn/features/home/controllers/LocationController.dart';
import 'package:pawrentingreborn/features/home/controllers/OrderController.dart';
import 'package:pawrentingreborn/features/home/models/cartItemModel.dart';
import 'package:pawrentingreborn/features/home/screens/Cart/Address.dart';
import 'package:pawrentingreborn/features/home/screens/Cart/Delivery.dart';

import 'package:pawrentingreborn/features/home/screens/Cart/Payment.dart';

import 'package:pawrentingreborn/features/home/screens/widgets/AddressSection.dart';
import 'package:pawrentingreborn/features/home/screens/widgets/DeliveryCard.dart';
import 'package:pawrentingreborn/features/home/screens/widgets/ItemSection.dart';
import 'package:pawrentingreborn/features/home/screens/widgets/PriceDetails.dart';
import 'package:pawrentingreborn/features/home/screens/widgets/VoucherCard.dart';
import 'package:pawrentingreborn/features/home/screens/widgets/Vouchers.dart';
import 'package:pawrentingreborn/features/profile/screens/AddLocationDetail.dart';
import 'package:pawrentingreborn/features/profile/screens/location.dart';
import 'package:pawrentingreborn/utils/constants/colors.dart';
import 'package:pawrentingreborn/utils/constants/images_strings.dart';

class OrderDetails extends StatelessWidget {
  final List<CartItemModel> items;
  final bool buyNow;
  const OrderDetails({super.key, required this.items, required this.buyNow});

  @override
  Widget build(BuildContext context) {
    LocationController locationController = Get.find();
    DeliveryController deliveryController = Get.find();
    OrderController orderController = Get.find();
    return Scaffold(
      backgroundColor: TColors.primary,
      appBar: TAppBar2(title: 'Order Details', subtitle: 'Check your order'),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 15),
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 40,
                child: Row(
                  children: [
                    Text(
                      'Total Price: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Obx(() => Text(
                          !buyNow
                              ? 'Rp${orderController.totalPrice.value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}'
                              : 'Rp${(items.first.quantity.value * items.first.productModel.salePrice + orderController.deliveryPrice.value + 1000).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: TColors.accent),
                        ))
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Get.to(() => Payment(
                      buyNow: buyNow,
                      items: items,
                    )),
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                    color: TColors.accent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      'Choose Payment',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'AlbertSans',
                          letterSpacing: 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/login/wallpaper-login.png'))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
            child: Center(
              child: Column(
                children: [
                  locationController.locationsList.length != 0
                      ? Obx(() => AddressSection(
                          location: locationController.locationsList[
                              locationController.selectedIndex.value]))
                      : GestureDetector(
                          onTap: () => Get.to(() => AddLocationDetail()),
                          child: Container(
                            height: 50,
                            color: Colors.red,
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => DeliveryCard(
                      delivery: deliveryController
                          .deliveryList[deliveryController.selectedIndex.value],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height:
                        items.length > 2 ? 275 : 125 * items.length.toDouble(),
                    child: ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return COItem(item: items[index]);
                        }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    child: VoucherCard(),
                    onTap: () => _showBottomSheet(context),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PriceDetails(
                    buyNow: buyNow,
                    items: items,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class VoucherExpansionController extends GetxController {
  var isExpanded = <bool>[false, false].obs;

  void togglePanel(int index) {
    isExpanded[index] = !isExpanded[index];
  }
}

void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      final controller = Get.put(VoucherExpansionController());
      return Wrap(children: [
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      size: 32,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Voucher',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Obx(() => ExpansionPanelList(
                    dividerColor: Colors.transparent,
                    elevation: 0,
                    expansionCallback: (panelIndex, isExpanded) {
                      controller.togglePanel(panelIndex);
                    },
                    children:
                        List.generate(controller.isExpanded.length, (index) {
                      return ExpansionPanel(
                          backgroundColor: Colors.transparent,
                          headerBuilder: (context, isExpanded) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  index == 0
                                      ? 'Usable Vouchers'
                                      : 'Unusable Vouchers',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            );
                          },
                          body: Vouchers(),
                          isExpanded: controller.isExpanded[index]);
                    }),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: TColors.grayFont, width: 1.25)),
                child: TextFormField(
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      border: InputBorder.none,
                      hintText: 'Enter voucher code here!',
                      contentPadding: EdgeInsets.all(8)),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ]);
    },
  );
}

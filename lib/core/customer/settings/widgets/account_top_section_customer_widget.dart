import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/models/customer.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';

class SectionTopCustomer extends ConsumerWidget {
  final Customer customer;
  const SectionTopCustomer({
    super.key,
    required this.customer,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      elevation: 5,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 5),
                customer.profilePhotoURL == null
                    ? const CircleAvatar(
                        radius: 22,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child:
                            Image.network(customer.profilePhotoURL!, width: 44),
                      ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customer.user?.name ?? "No name",
                      style: appStyle(
                          size: 14, color: Colors.black, fw: FontWeight.w500),
                    ),
                    Text("#${customer.customerCode ?? "No name"}",
                        style: appStyle(
                            size: 14, color: Colors.black, fw: FontWeight.w500))
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Routemaster.of(context).push('/customer-account/edit-profile');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                "Edit Profile",
                style: appStyle(
                    size: 14, color: Colors.white, fw: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

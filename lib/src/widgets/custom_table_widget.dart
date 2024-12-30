import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

class DeliverMaterialTable extends StatelessWidget {
  final List<Items> material;

  const DeliverMaterialTable({
    super.key,
    required this.material,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0,
        ),
        borderRadius: BorderRadius.circular(
          Dimensions.radiusDefault,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          Dimensions.radiusDefault,
        ),
        child: DataTable(
          border: TableBorder(
            borderRadius: BorderRadius.circular(
              Dimensions.radiusDefault,
            ),
          ),
          dataRowMinHeight: 30,
          headingRowHeight: Dimensions.tableHeadingHeight,
          dividerThickness: 1.0,
          headingRowColor: MaterialStateProperty.all(AppColors.kPrimaryColor),
          dataRowColor: MaterialStateProperty.all(
            AppColors.kPrimaryColor.withOpacity(
              0.05,
            ),
          ),
          headingTextStyle:
              AppStyles.text12PxMedium.copyWith(color: AppColors.white),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              Dimensions.radiusDefault,
            ),
          ),
          columns: List.generate(
            AppConstants.tableList.length,
            (index) => DataColumn(
              label: Text(
                AppConstants.tableList[index],
                style: AppStyles.text12PxMedium,
              ),
            ),
          ),
          rows: List<DataRow>.generate(
            material.length,
            (index) => DataRow(
              cells: [
                DataCell(
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      material[index].name,
                      style: AppStyles.text10PxRegular,
                    ),
                  ),
                ),
                DataCell(
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      "${material[index].weight}",
                      style: AppStyles.text10PxRegular,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

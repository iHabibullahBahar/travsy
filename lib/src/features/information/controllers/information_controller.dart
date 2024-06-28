import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travsy/src/features/information/domain/models/activity_model.dart';
import 'package:travsy/src/features/information/domain/models/diet_model.dart';
import 'package:travsy/src/features/information/domain/models/goal_model.dart';
import 'package:travsy/src/features/information/domain/models/meal_model.dart';
import 'package:travsy/src/features/profile/controllers/profile_controller.dart';
import 'package:travsy/src/helper/api_services.dart';
import 'package:travsy/src/utils/api_urls.dart';
import 'package:travsy/src/utils/app_constants.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/images.dart';

class InformationController extends GetxController {
  static InformationController instance = Get.find();
  static DateTime? selectedDateOfBirth = DateTime.now();
  static DateTime? initialDateOfBirth = DateTime.now();

  static RxString? selectedUnit = "metric".obs;
  int selectedIndex = 0;
  static RxDouble progress = 0.125.obs;
  List<int> heightInCmList = List.generate(150, (index) => 50 + index);
  List<int> heightInInchesList = List.generate(80, (index) => 30 + index);
  List<int> weightInKgList = List.generate(200, (index) => 30 + index);
  List<int> weightInLbsList = List.generate(300, (index) => 60 + index);

  static List<String> selectedDietList = [];
  static String selectedGender = "initial";
  static int selectedHeight = 170;
  static int selectedWeight = 70;
  static String selectedGoal = "initial";
  static bool isMealGenerationPermitted = false;
  bool isDateSelected = false;
  String selectedDate = "";
  static MealModel selectedMealStructure = MealModel(
    title: "initial",
    image: "",
    descriptionWidget: Container(),
  );
  void clearData() {
    progress.value = 0.125;
    selectedIndex = 0;
    selectedDietList = [];
    selectedGender = "initial";
    selectedHeight = 170;
    selectedWeight = 70;
    selectedUnit = "metric".obs;
    selectedGoal = "initial";
    isMealGenerationPermitted = false;
    isDateSelected = false;
    selectedDate = "";
    selectedMealStructure = MealModel(
      title: "initial",
      image: "",
      descriptionWidget: Container(),
    );
    selectedActivityLevel = ActivityModel(
      title: "initial",
      endpoint: "initial",
      image: "",
      descriptionWidget: Container(),
    );
    for (int i = 0; i < dietList.length; i++) {
      dietList[i].isSelected = false;
      dietList[i].isDeactivated = false;
    }
    for (int i = 0; i < goalList.length; i++) {
      goalList[i].isSelected = false;
    }
    for (int i = 0; i < activityList.length; i++) {
      activityList[i].isSelected = false;
    }
    for (int i = 0; i < mealList.length; i++) {
      mealList[i].isSelected = false;
    }
  }

  ///Activity Level variables
  static ActivityModel selectedActivityLevel = ActivityModel(
    title: "initial",
    endpoint: "initial",
    image: "",
    descriptionWidget: Container(),
  );

  //Generate List of Height in feet and inches in int format
  List<int> heightInFeetInchesList = List.generate(
      150,
      (index) =>
          (5 * (50 + index) ~/ 12) * 12 +
          (50 + index) -
          ((5 * (50 + index) ~/ 12) * 12) ~/ 12);

  @override
  void onInit() {
    super.onInit();
  }

  RxBool isDataUpdating = false.obs;
  Future<bool> updateDietary({required List<String> dietList}) async {
    try {
      var requestBody = {
        "items": dietList,
      };
      isDataUpdating.value = true;
      var response = await ApiServices.instance.getResponse(
        requestBody: requestBody,
        endpoint: zUpdateDiatariesEndpoint,
        isAuthToken: true,
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        isDataUpdating.value = false;
        return true;
      } else {
        isDataUpdating.value = false;
        return false;
      }
    } catch (e) {
      isDataUpdating.value = false;
      return false;
    }
  }

  Future<bool> updateGender({required String gender}) async {
    try {
      var requestBody = {
        "gender": gender,
      };
      isDataUpdating.value = true;
      var response = await ApiServices.instance.getResponse(
        requestBody: requestBody,
        endpoint: zUpdateGenderEndpoint,
        isAuthToken: true,
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        isDataUpdating.value = false;
        return true;
      } else {
        isDataUpdating.value = false;
        return false;
      }
    } catch (e) {
      isDataUpdating.value = false;
      return false;
    }
  }

  Future<bool> updateAge({required String dob}) async {
    try {
      var requestBody = {
        "dob": dob,
      };
      isDataUpdating.value = true;
      var response = await ApiServices.instance.getResponse(
        requestBody: requestBody,
        endpoint: zUpdateDOBEndpoint,
        isAuthToken: true,
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        isDataUpdating.value = false;
        return true;
      } else {
        isDataUpdating.value = false;
        return false;
      }
    } catch (e) {
      isDataUpdating.value = false;
      return false;
    }
  }

  Future<bool> updateHeight({required int height}) async {
    try {
      var requestBody = {
        "height": height,
      };
      isDataUpdating.value = true;
      var response = await ApiServices.instance.getResponse(
        requestBody: requestBody,
        endpoint: zUpdateHeightEndpoint,
        isAuthToken: true,
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        isDataUpdating.value = false;
        return true;
      } else {
        isDataUpdating.value = false;
        return false;
      }
    } catch (e) {
      isDataUpdating.value = false;
      return false;
    }
  }

  Future<bool> updateWeight({required int weight}) async {
    try {
      var requestBody = {
        "weight": weight,
      };
      isDataUpdating.value = true;
      var response = await ApiServices.instance.getResponse(
        requestBody: requestBody,
        endpoint: zUpdateWeightEndpoint,
        isAuthToken: true,
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        isDataUpdating.value = false;
        return true;
      } else {
        isDataUpdating.value = false;
        return false;
      }
    } catch (e) {
      isDataUpdating.value = false;
      return false;
    }
  }

  Future<bool> updateActivityLevel({required String level}) async {
    try {
      var requestBody = {
        "item": level,
      };
      isDataUpdating.value = true;
      var response = await ApiServices.instance.getResponse(
        requestBody: requestBody,
        endpoint: zUpdateActivityLevelEndpoint,
        isAuthToken: true,
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        isDataUpdating.value = false;
        return true;
      } else {
        isDataUpdating.value = false;
        return false;
      }
    } catch (e) {
      isDataUpdating.value = false;
      return false;
    }
  }

  Future<bool> updateGoals({required String goal}) async {
    try {
      var requestBody = {
        "goals": goal,
      };
      isDataUpdating.value = true;
      var response = await ApiServices.instance.getResponse(
        requestBody: requestBody,
        endpoint: zUpdateGoalsEndpoint,
        isAuthToken: true,
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        isDataUpdating.value = false;
        return true;
      } else {
        isDataUpdating.value = false;
        return false;
      }
    } catch (e) {
      isDataUpdating.value = false;
      return false;
    }
  }

  Future<bool> updateMealStructure({required MealModel mealModel}) async {
    try {
      var requestBody = {
        "meal1": mealModel.meal1,
        "meal2": mealModel.meal2,
        "meal3": mealModel.meal3,
        "snack1": mealModel.snack1,
        "snack2": mealModel.snack2,
      };
      isDataUpdating.value = true;
      var response = await ApiServices.instance.getResponse(
        requestBody: requestBody,
        endpoint: zUpdateMealStructureEndpoint,
        isAuthToken: true,
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        isDataUpdating.value = false;
        return true;
      } else {
        isDataUpdating.value = false;
        return false;
      }
    } catch (e) {
      isDataUpdating.value = false;
      return false;
    }
  }

  List<MealModel> mealList = [
    MealModel(
      title: zMealText1,
      image: zMealImage1,
      meal1: "breakfast",
      meal2: "lunch",
      snack1: "snack",
      descriptionWidget: RichText(
        text: TextSpan(
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 10,
            color: zTextColor.withOpacity(0.5),
          ),
          children: const [
            TextSpan(
              text: "Includes ",
            ),
            TextSpan(
              text: "Lunch",
              style: TextStyle(
                color: Color(
                  0xFFFF6654,
                ),
              ),
            ),
            TextSpan(
              text: ", ",
            ),
            TextSpan(
              text: "Dinner",
              style: TextStyle(
                color: Color(
                  0xFFFF6654,
                ),
              ),
            ),
            TextSpan(
              text: " & ",
            ),
            TextSpan(
              text: "Snack/Dessert.",
              style: TextStyle(
                color: Color(
                  0xFFFF6654,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    MealModel(
      title: zMealText2,
      image: zMealImage2,
      meal1: "breakfast",
      meal2: "lunch",
      snack1: "snack",
      snack2: "dessert",
      descriptionWidget: RichText(
        text: TextSpan(
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 10,
            color: zTextColor.withOpacity(0.5),
          ),
          children: const [
            TextSpan(
              text: "Includes ",
            ),
            TextSpan(
              text: "Lunch",
              style: TextStyle(
                color: Color(
                  0xFFFF6654,
                ),
              ),
            ),
            TextSpan(
              text: ", ",
            ),
            TextSpan(
              text: "Dinner",
              style: TextStyle(
                color: Color(
                  0xFFFF6654,
                ),
              ),
            ),
            TextSpan(
              text: ", ",
            ),
            TextSpan(
              text: "Snack",
              style: TextStyle(
                color: Color(
                  0xFFFF6654,
                ),
              ),
            ),
            TextSpan(
              text: " & ",
            ),
            TextSpan(
              text: "Dessert.",
              style: TextStyle(
                color: Color(
                  0xFFFF6654,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    MealModel(
      title: zMealText3,
      image: zMealImage3,
      meal1: "breakfast",
      meal2: "lunch",
      meal3: "dinner",
      snack1: "snack",
      descriptionWidget: RichText(
        text: TextSpan(
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 10,
            color: zTextColor.withOpacity(0.5),
          ),
          children: const [
            TextSpan(
              text: "Includes ",
            ),
            TextSpan(
              text: "Breakfast",
              style: TextStyle(
                color: Color(
                  0xFFFF6654,
                ),
              ),
            ),
            TextSpan(
              text: ", ",
            ),
            TextSpan(
              text: "Lunch",
              style: TextStyle(
                color: Color(
                  0xFFFF6654,
                ),
              ),
            ),
            TextSpan(
              text: ", ",
            ),
            TextSpan(
              text: "Dinner",
              style: TextStyle(
                color: Color(
                  0xFFFF6654,
                ),
              ),
            ),
            TextSpan(
              text: " & ",
            ),
            TextSpan(
              text: "Snack/Dessert.",
              style: TextStyle(
                color: Color(
                  0xFFFF6654,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    MealModel(
      title: zMealText4,
      image: zMealImage4,
      meal1: "breakfast",
      meal2: "lunch",
      meal3: "dinner",
      snack1: "snack",
      snack2: "dessert",
      descriptionWidget: RichText(
        text: TextSpan(
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 10,
            color: zTextColor.withOpacity(0.5),
          ),
          children: const [
            TextSpan(
              text: "Includes ",
            ),
            TextSpan(
              text: "Breakfast",
              style: TextStyle(
                color: Color(
                  0xFFFF6654,
                ),
              ),
            ),
            TextSpan(
              text: ", ",
            ),
            TextSpan(
              text: "Lunch",
              style: TextStyle(
                color: Color(
                  0xFFFF6654,
                ),
              ),
            ),
            TextSpan(
              text: ", ",
            ),
            TextSpan(
              text: "Dinner",
              style: TextStyle(
                color: Color(
                  0xFFFF6654,
                ),
              ),
            ),
            TextSpan(
              text: ", ",
            ),
            TextSpan(
              text: "Snack",
              style: TextStyle(
                color: Color(
                  0xFFFF6654,
                ),
              ),
            ),
            TextSpan(
              text: " & ",
            ),
            TextSpan(
              text: "Dessert.",
              style: TextStyle(
                color: Color(
                  0xFFFF6654,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ];

  List<DietModel> dietList = [
    DietModel(
      title: "No Dietary Requirements",
      endPoint: 'none',
      image: zDietImage1,
    ),
    DietModel(
      title: zDietText1,
      endPoint: 'gluten_free',
      image: zDietImage1,
    ),
    DietModel(
      title: zDietText2,
      endPoint: 'vegan',
      image: zDietImage2,
    ),
    DietModel(
      title: zDietText3,
      endPoint: 'nut_free',
      image: zDietImage3,
    ),
    DietModel(
      title: zDietText4,
      endPoint: 'dairy_free',
      image: zDietImage4,
    ),
    DietModel(
      title: zDietText5,
      endPoint: 'vegetarian',
      image: zDietImage5,
    ),
    DietModel(
      title: zDietText6,
      endPoint: 'egg_free',
      image: zDietImage6,
    ),
    DietModel(
      title: zDietText7,
      endPoint: 'pescetarian',
      image: zDietImage7,
    ),
    DietModel(
      title: zDietText8,
      endPoint: 'soy_free',
      image: zDietImage8,
    ),
    DietModel(
      title: zDietText9,
      endPoint: 'seafood_free',
      image: zDietImage9,
    ),
    DietModel(
      title: zDietText10,
      endPoint: 'red_meat_free',
      image: zDietImage10,
    )
  ];
  List<GoalModel> goalList = [
    GoalModel(
      title: zGoal1Text,
      endpoint: "lose_weight",
      image: zGoalImage1,
    ),
    GoalModel(
      title: zGoal2Text,
      endpoint: "maintain",
      image: zGoalImage2,
    ),
    GoalModel(
      title: zGoal3Text,
      endpoint: "gain_muscle",
      image: zGoalImage3,
    )
  ];

  int getSelectedMealIndex() {
    var profile = ProfileController.instance.profileModel.data!;
    if (profile.meal3 == null && profile.snack2 == null) {
      return 0;
    } else if (profile.meal3 == null) {
      return 1;
    } else if (profile.snack2 == null) {
      return 2;
    } else {
      return 3;
    }
  }

  List<int> getSelectedDietList() {
    var profile = ProfileController.instance.profileModel.data!;
    List<int> selectedDietList = [];
    return selectedDietList;
  }

  int getSelectedGoalIndex() {
    var profile = ProfileController.instance.profileModel.data!;
    if (profile.goal == "lose_weight") {
      return 0;
    } else if (profile.goal == "maintain") {
      return 1;
    } else {
      return 2;
    }
  }

  List<ActivityModel> activityList = [
    ActivityModel(
      title: "Sedentary",
      endpoint: "sedentary",
      image: zActivityImage1,
      descriptionWidget: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 10,
          ),
          children: [
            const TextSpan(
              text: "Little",
              style: TextStyle(
                color: Color(
                  0xFFFF395D,
                ),
              ),
            ),
            TextSpan(
                text: " or ",
                style: TextStyle(
                  color: zTextColor.withOpacity(0.5),
                )),
            const TextSpan(
                text: " No ",
                style: TextStyle(
                  color: Color(
                    0xFFFF395D,
                  ),
                )),
            TextSpan(
              text: " Exercise",
              style: TextStyle(
                color: zTextColor.withOpacity(0.5),
              ),
            )
          ],
        ),
      ),
    ),
    ActivityModel(
      title: "Moderately Active",
      endpoint: "moderately_active",
      image: zActivityImage2,
      descriptionWidget: RichText(
        text: TextSpan(
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: zTextColor.withOpacity(0.5),
            fontSize: 10,
          ),
          children: [
            const TextSpan(
                text: "Moderate ",
                style: TextStyle(
                  color: Color(0xFFEF7922),
                )),
            TextSpan(
              text: "Exercise/Sports ",
            ),
            const TextSpan(
                text: "3-5 days ",
                style: TextStyle(
                  color: Color(0xFFEF7922),
                )),
            TextSpan(
              text: "weekly",
            )
          ],
        ),
      ),
    ),
    ActivityModel(
      title: "Very Active",
      endpoint: "very_active",
      image: zActivityImage3,
      descriptionWidget: RichText(
        text: TextSpan(
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 10,
            color: zTextColor.withOpacity(0.5),
          ),
          children: [
            const TextSpan(
                text: "Hard ",
                style: TextStyle(
                  color: Color(
                    0xFF4CBF92,
                  ),
                )),
            TextSpan(
              text: "Exercise/Sports ",
            ),
            const TextSpan(
              text: "6-7 days ",
              style: TextStyle(
                color: Color(
                  0xFF4CBF92,
                ),
              ),
            ),
            TextSpan(
              text: "weekly",
            ),
          ],
        ),
      ),
    ),
    ActivityModel(
      title: "Extra Active",
      endpoint: "extra_active",
      image: zActivityImage4,
      descriptionWidget: RichText(
        text: TextSpan(
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 10,
            color: zTextColor.withOpacity(0.5),
          ),
          children: const [
            TextSpan(
              text: "Very Hard ",
              style: TextStyle(
                color: Color(
                  0xFF12754E,
                ),
              ),
            ),
            TextSpan(
              text: "Exercise/Sports &",
            ),
            TextSpan(
              text: "physical ",
              style: TextStyle(
                color: Color(
                  0xFF12754E,
                ),
              ),
            ),
            TextSpan(
              text: "job",
            ),
          ],
        ),
      ),
    ),
  ];
  int getSelectedActivityIndex() {
    var profile = ProfileController.instance.profileModel.data!;
    if (profile.activityLevel == "sedentary") {
      return 0;
    } else if (profile.activityLevel == "moderately_active") {
      return 1;
    } else if (profile.activityLevel == "very_active") {
      return 2;
    } else if (profile.activityLevel == "extra_active") {
      return 3;
    }
    return 0;
  }

  setDietList(int i) {
    if (InformationController.instance.dietList[i].isSelected) {
      InformationController.instance.dietList[i].isSelected = false;
      InformationController.selectedDietList = [];
      for (int j = 0; j < InformationController.instance.dietList.length; j++) {
        if (j == i) {
          continue;
        }
        InformationController.instance.dietList[j].isSelected = false;
        InformationController.instance.dietList[j].isDeactivated = false;
      }
    } else {
      for (int j = 0; j < InformationController.instance.dietList.length; j++) {
        if (j == i) {
          continue;
        }
        InformationController.instance.dietList[i].isSelected = true;
        InformationController.instance.dietList[j].isSelected = false;
        InformationController.selectedDietList = [];
        InformationController.instance.dietList[j].isDeactivated = true;
      }
    }
  }
}

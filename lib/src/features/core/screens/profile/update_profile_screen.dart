import 'package:dhamni/src/common_widgets/phone_input_formatter.dart';
import 'package:dhamni/src/constants/colors.dart';
import 'package:dhamni/src/constants/image_strings.dart';
import 'package:dhamni/src/constants/sizes.dart';
import 'package:dhamni/src/constants/text_strings.dart';
import 'package:dhamni/src/features/authentication/models/user_model.dart';
import 'package:dhamni/src/features/authentication/screens/forget_password/forget_password_options/forget_password_modal_bottom_btn_widget.dart';
import 'package:dhamni/src/features/core/controllers/profile_controller.dart';
import 'package:dhamni/src/features/core/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({Key? key}) : super(key: key);

  // ignore: non_constant_identifier_names
  late String college_id;
  final _college = [
    "Select College Name",
    "Acharya Narendra Dev College",
    "Aditi Mahavidyalaya",
    "Agricultural Economics Research Centre",
    "Ahilya Bai College of Nursing",
    "Amar Jyoti Institute of Physiotherapy",
    "Aryabhatta College(Formally Ram Lal Anand College-Evg.)",
    "Atma Ram Sanatan Dharma College",
    "Ayurvedic & Unani Tibia College",
    "Bhagini Nivedita College",
    "Bharati College",
    "Bhaskaracharya College of Applied Sciences",
    "Bhim Rao Ambedkar College",
    "School of Open Learning (SOL)",
    "Centre for Detector & Related Software Technology",
    "Centre for Environmental Management of Degraded Ecosystems (CEMDE)",
    "Centre for Genetic Manipulation of Crop Plants",
    "Centre for Global Studies",
    "Centre for Himalayan Studies",
    "Centre for India-Canada Studies",
    "Centre for Innovation in Infectious Disease Research, Education and Training (CIIDRET)",
    "Centre for Interdisciplinary Studies of Mountain and Hill Environment",
    "Centre for Science Education & Communication",
    "Chacha Nehru Bal Chikitsalaya",
    "Cluster Innovation Centre (CIC)",
    "College of Art",
    "College of Nursing at Army Hospital (R&R)",
    "College of Vocational Studies",
    "Daulat Ram College",
    "Deen Dayal Upadhyaya College",
    "Delhi College of Arts & Commerce",
    "Delhi Institute of Pharmaceutical Sciences and Research",
    "Delhi School of Economics",
    "Deshbandhu College(Morning)",
    "Dr. B.R. Ambedkar Center for Biomedical Research (ACBR)",
    "Durga Bai Deshmukh College of Special Edu.(VI)",
    "Dyal Singh College",
    "Dyal Singh College (Evening)",
    "Florence Nightingale College of Nursing",
    "Gargi College",
    "Hans Raj College",
    "Hindu College",
    "Holy Family College of Nursing",
    "Indira Gandhi Institute of Physical Education & Sports Sciences",
    "Indraprastha College for Women",
    "Institute of Home Economics",
    "Institute of Informatics & Communication(IIC)",
    "Institute of Lifelong Learning(ILLL)",
    "Inter Disciplinary Centre for Plant Genomics",
    "Janki Devi Memorial College",
    "Jesus & Mary College",
    "Kalindi College for Women",
    "Kamla Nehru College for Women",
    "Keshav Mahavidyalaya",
    "Kirori Mal College",
    "Lady Hardinge Medical College",
    "Lady Irwin College",
    "Lady Shri Ram College for Women",
    "Lakshmi Bai College for Women",
    "Maharaja Agarsen College",
    "Maharshi Valmiki College of Education",
    "Maitreyi College for Women",
    "Mata Sundri College for Women",
    "Maulana Azad Institute of Dental Sciences",
    "Maulana Azad Medical College",
    "Miranda House",
    "Moti Lal Nehru College",
    "Moti Lal Nehru College (Evening)",
    "University College of Medical Sciences",
    "Nehru Homeopathic Medical College & Hospital",
    "Netaji Subhash Institute of Technology",
    "P.G.D.A.V. College",
    "P.G.D.A.V. College (Evening)",
    "Prof. D.S. Kothari Centre for Science Ethics & Education",
    "Pt. Deendayal Upadhyaya Institute of Physically Handicapped",
    "Rajdhani College",
    "Rajkumari Amrit Kaur College of Nursing",
    "Ram Lal Anand College",
    "Ramanujan College",
    "Ramjas College",
    "Satyawati College",
    "Satyawati College (Evening)",
    "School of Open Learning ( Erstwhile School of Correspondence & Continuing Education)",
    "School of Rehabilitation Sciences",
    "Shaheed Bhagat Singh College",
    "Shaheed Bhagat Singh College (Evening)",
    "Shaheed Rajguru College of Applied Sciences for Women",
    "Shaheed Sukhdev College of Business Studies",
    "Shivaji College",
    "Shri Ram College of Commerce",
    "Shyam Lal College",
    "Shyam Lal College (Evening)",
    "Shyama Prasad Mukherji College for Women",
    "Sri Aurobindo College",
    "Sri Aurobindo College (Evening)",
    "Sri Guru Gobind Singh College of Commerce",
    "Sri Guru Nanak Dev Khalsa College",
    "Sri Guru Tegh Bahadur Khalsa College",
    "Sri Venkateswara College",
    "St. Stephen's College",
    "Swami Shraddhanand College",
    "Vallabhbhai Patel Chest Institute",
    "Vivekananda College",
    "Women Studies & Development Centre (WSDC)",
    "Zakir Husain Delhi College",
    "Zakir Husain Post Graduate Evening College"
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final PhoneInputFormatter _phoneFormatter = PhoneInputFormatter();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          tEditProfile,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(tDefaultSize),
        child: FutureBuilder(
          future: controller.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                UserModel user = snapshot.data as UserModel;
                final fullName = TextEditingController(text: user.fullName);
                final pinCode = TextEditingController(text: user.pinCode);
                college_id = user.collegeName;

                return Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image(
                              image: AssetImage(tUserProfileImage),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: tPrimaryColor,
                            ),
                            child: Icon(
                              LineAwesomeIcons.camera,
                              color: Color.fromARGB(255, 255, 255, 255),
                              size: 20.0,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: fullName,
                            minLines: null,
                            maxLines: null,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person_outline_rounded),
                              labelText: tFullName,
                              hintText: tFullName,
                              // border: OutlineInputBorder(),
                            ),
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: tFormHeight - 20),
                          TextFormField(
                            readOnly: true,
                            initialValue: user.email,
                            minLines: null,
                            maxLines: null,
                            decoration: const InputDecoration(
                                labelText: tEmail,
                                hintText: tEmail,
                                prefixIcon: Icon(Icons.email_outlined)),
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: tFormHeight - 20),
                          TextFormField(
                            readOnly: true,
                            initialValue: user.phoneNo,
                            keyboardType: TextInputType.number,
                            inputFormatters: [_phoneFormatter],
                            minLines: null,
                            maxLines: null,
                            decoration: const InputDecoration(
                              labelText: tPhoneNo,
                              hintText: tPhoneNo,
                              prefixIcon: Icon(Icons.numbers),
                            ),
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: tFormHeight - 20),
                          DropdownButtonFormField(
                            value: college_id,
                            itemHeight: null,
                            isExpanded: true,
                            decoration: const InputDecoration(
                                label: Text(tCollegeName),
                                prefixIcon: Icon(Icons.home_rounded)),
                            style: TextStyle(fontSize: 20, color: Colors.black),

                            // dropdownColor: Colors.black,
                            // focusColor: Colors.black,
                            items: _college
                                .map((e) => DropdownMenuItem(
                                      child: Text(e),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (value) {
                              college_id = value!;
                            },
                          ),
                          TextFormField(
                            controller: pinCode,
                            keyboardType: TextInputType.number,
                            minLines: null,
                            maxLines: null,
                            decoration: const InputDecoration(
                                label: Text(tPinCode),
                                prefixIcon: Icon(Icons.numbers_outlined)),
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: tFormHeight - 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                final userNewData = UserModel(
                                  email: user.email,
                                  password: user.password,
                                  phoneNo: user.phoneNo,
                                  fullName: fullName.text.trim(),
                                  collegeName: college_id,
                                  pinCode: pinCode.text.trim(),
                                  dateTime: user.dateTime,
                                );

                                await controller.UpdateRecord(
                                    user, userNewData);
                                Get.snackbar("Success", "Record Updated.",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor:
                                        Colors.green.withOpacity(0.1),
                                    colorText: Colors.green);
                                Get.offAll(() => const Dashboard());
                              },
                              child: const Text(tEditProfile),
                              style: ElevatedButton.styleFrom(
                                side: BorderSide.none,
                                shape: StadiumBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(height: tFormHeight),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    ForgetPasswordScreen
                                        .buildShoeModalBottomSheet(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.redAccent.withOpacity(0.1),
                                      elevation: 0,
                                      foregroundColor: Colors.red,
                                      shape: const StadiumBorder(),
                                      side: BorderSide.none),
                                  child: const Text(tResetPassword))
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                return Center(child: Text('Sonething went Wrong !!!'));
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      )),
    );
  }
}

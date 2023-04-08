import 'package:dhamni/src/constants/colors.dart';
import 'package:dhamni/src/constants/image_strings.dart';
import 'package:dhamni/src/constants/sizes.dart';
import 'package:dhamni/src/constants/text_strings.dart';
import 'package:dhamni/src/features/authentication/models/user_model.dart';
import 'package:dhamni/src/features/core/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({Key? key}) : super(key: key);

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          tEditProfile,
          style: Theme.of(context).textTheme.headlineMedium,
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
                UserModel userData = snapshot.data as UserModel;
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
                            initialValue: userData.fullName,
                            minLines: null,
                            maxLines: null,
                            decoration: const InputDecoration(
                                label: Text(tFullName),
                                prefixIcon: Icon(Icons.person_outline_rounded)),
                          ),
                          const SizedBox(height: tFormHeight - 20),
                          TextFormField(
                            initialValue: userData.email,
                            minLines: null,
                            maxLines: null,
                            decoration: const InputDecoration(
                                label: Text(tEmail),
                                prefixIcon: Icon(Icons.email_outlined)),
                          ),
                          const SizedBox(height: tFormHeight - 20),
                          TextFormField(
                            initialValue: userData.phoneNo,
                            minLines: null,
                            maxLines: null,
                            decoration: const InputDecoration(
                                label: Text(tPhoneNo),
                                prefixIcon: Icon(Icons.numbers)),
                          ),
                          const SizedBox(height: tFormHeight - 20),
                          DropdownButtonFormField(
                            value: userData.collegeName,
                            itemHeight: null,
                            isExpanded: true,
                            decoration: const InputDecoration(
                                label: Text(tCollegeName),
                                prefixIcon: Icon(Icons.home_rounded)),
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
                          // const SizedBox(height: tFormHeight - 20),
                          // TextFormField(
                          //   initialValue: userData.password,
                          //   decoration: const InputDecoration(
                          //       label: Text(tPassword),
                          //       prefixIcon: Icon(Icons.fingerprint)),
                          // ),
                          const SizedBox(height: tFormHeight - 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () =>
                                  Get.to(() => UpdateProfileScreen()),
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
                              Text.rich(
                                TextSpan(
                                  text: tJoined,
                                  style: TextStyle(fontSize: 12),
                                  children: [
                                    TextSpan(
                                      text: tJoinedAt,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.redAccent.withOpacity(0.1),
                                      elevation: 0,
                                      foregroundColor: Colors.red,
                                      shape: const StadiumBorder(),
                                      side: BorderSide.none),
                                  child: const Text(tDelete))
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

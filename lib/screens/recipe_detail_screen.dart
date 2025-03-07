// // import 'dart:convert';

// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;

// // class RecipeDetailScreen extends StatefulWidget {
// //   final int recipeId;
// //   final String recipeTitle;

// //   const RecipeDetailScreen(
// //       {Key? key, required this.recipeId, required this.recipeTitle})
// //       : super(key: key);

// //   @override
// //   _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
// // }

// // class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
// //   List<String> instructions = [];
// //   final String apiKey =
// //       "ef99030b3fcb4413b41720d9be3634e1"; // Replace with your API key

// //   @override
// //   void initState() {
// //     super.initState();
// //     fetchRecipeInstructions();
// //   }

// //   Future<void> fetchRecipeInstructions() async {
// //     String apiUrl =
// //         "https://api.spoonacular.com/recipes/${widget.recipeId}/information?includeNutrition=false&apiKey=$apiKey";

// //     try {
// //       final response = await http.get(Uri.parse(apiUrl));
// //       if (response.statusCode == 200) {
// //         var data = json.decode(response.body);
// //         var steps = data["analyzedInstructions"] ?? [];

// //         if (steps.isNotEmpty && steps[0]["steps"] != null) {
// //           setState(() {
// //             instructions =
// //                 List<String>.from(steps[0]["steps"].map((s) => s["step"]));
// //           });
// //         } else {
// //           setState(() {
// //             instructions = ["No detailed steps available."];
// //           });
// //         }
// //       } else {
// //         throw Exception('Failed to load recipe steps');
// //       }
// //     } catch (error) {
// //       setState(() {
// //         instructions = ["Error fetching instructions: $error"];
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text(widget.recipeTitle)),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: SingleChildScrollView(
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text("Cooking Instructions:",
// //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
// //               const SizedBox(height: 10),
// //               if (instructions.isNotEmpty)
// //                 Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: instructions
// //                       .asMap()
// //                       .entries
// //                       .map((entry) => Padding(
// //                             padding: const EdgeInsets.symmetric(vertical: 5),
// //                             child: Text("${entry.key + 1}. ${entry.value}",
// //                                 style: TextStyle(fontSize: 16)),
// //                           ))
// //                       .toList(),
// //                 )
// //               else
// //                 const Center(child: CircularProgressIndicator()),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class RecipeDetailScreen extends StatefulWidget {
//   final int recipeId;
//   final String recipeTitle;

//   const RecipeDetailScreen({Key? key, required this.recipeId, required this.recipeTitle}) : super(key: key);

//   @override
//   _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
// }

// class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
//   List<String> instructions = [];
//   String? videoUrl;
//   YoutubePlayerController? _youtubeController;

//   final String apiKey = "YOUR_SPOONACULAR_API_KEY"; // Replace with your API key

//   @override
//   void initState() {
//     super.initState();
//     fetchRecipeInstructions();
//   }

//   Future<void> fetchRecipeInstructions() async {
//     String apiUrl = "https://api.spoonacular.com/recipes/${widget.recipeId}/information?includeNutrition=false&apiKey=$apiKey";

//     try {
//       final response = await http.get(Uri.parse(apiUrl));
//       if (response.statusCode == 200) {
//         var data = json.decode(response.body);
//         var steps = data["analyzedInstructions"] ?? [];

//         if (steps.isNotEmpty && steps[0]["steps"] != null) {
//           setState(() {
//             instructions = List<String>.from(steps[0]["steps"].map((s) => s["step"]));
//           });
//         } else {
//           setState(() {
//             instructions = ["No detailed steps available."];
//           });
//         }

//         // Get video URL
//         if (data["spoonacularSourceUrl"] != null) {
//           setState(() {
//             videoUrl = data["spoonacularSourceUrl"];
//             String? videoId = YoutubePlayer.convertUrlToId(videoUrl!);
//             if (videoId != null) {
//               _youtubeController = YoutubePlayerController(
//                 initialVideoId: videoId,
//                 flags: YoutubePlayerFlags(autoPlay: false, mute: false),
//               );
//             }
//           });
//         }
//       } else {
//         throw Exception('Failed to load recipe steps');
//       }
//     } catch (error) {
//       setState(() {
//         instructions = ["Error fetching instructions: $error"];
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _youtubeController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.recipeTitle)),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Cooking Instructions:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 10),
//               if (instructions.isNotEmpty)
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: instructions
//                       .asMap()
//                       .entries
//                       .map((entry) => Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 5),
//                             child: Text("${entry.key + 1}. ${entry.value}", style: TextStyle(fontSize: 16)),
//                           ))
//                       .toList(),
//                 )
//               else
//                 const Center(child: CircularProgressIndicator()),

//               const SizedBox(height: 20),

//               // Show Video if Available
//               if (_youtubeController != null) ...[
//                 Text("Watch Recipe Video:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 10),
//                 YoutubePlayer(
//                   controller: _youtubeController!,
//                   showVideoProgressIndicator: true,
//                 ),
//               ]
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class RecipeDetailScreen extends StatefulWidget {
  final int recipeId;
  final String recipeTitle;

  const RecipeDetailScreen(
      {Key? key, required this.recipeId, required this.recipeTitle})
      : super(key: key);

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  List<String> instructions = [];
  String? videoId;
  YoutubePlayerController? _youtubeController;

  final String apiKey =
      "ef99030b3fcb4413b41720d9be3634e1"; // Replace with your Spoonacular API key

  @override
  void initState() {
    super.initState();
    fetchRecipeDetails();
  }

  Future<void> fetchRecipeDetails() async {
    String apiUrl =
        "https://api.spoonacular.com/recipes/${widget.recipeId}/information?includeNutrition=false&apiKey=$apiKey";
    String videoApiUrl =
        "https://api.spoonacular.com/food/videos/search?query=${widget.recipeTitle}&apiKey=$apiKey";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var steps = data["analyzedInstructions"] ?? [];

        if (steps.isNotEmpty && steps[0]["steps"] != null) {
          setState(() {
            instructions =
                List<String>.from(steps[0]["steps"].map((s) => s["step"]));
          });
        } else {
          setState(() {
            instructions = ["No detailed steps available."];
          });
        }
      } else {
        throw Exception('Failed to load recipe steps');
      }

      // Fetch related recipe video
      final videoResponse = await http.get(Uri.parse(videoApiUrl));
      if (videoResponse.statusCode == 200) {
        var videoData = json.decode(videoResponse.body);
        if (videoData["videos"] != null && videoData["videos"].isNotEmpty) {
          setState(() {
            videoId = YoutubePlayer.convertUrlToId(
                videoData["videos"][0]["youTubeId"]);
            if (videoId != null) {
              _youtubeController = YoutubePlayerController(
                initialVideoId: videoId!,
                flags: YoutubePlayerFlags(autoPlay: false, mute: false),
              );
            }
          });
        }
      }
    } catch (error) {
      setState(() {
        instructions = ["Error fetching details: $error"];
      });
    }
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.recipeTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Cooking Instructions:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              if (instructions.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: instructions
                      .asMap()
                      .entries
                      .map((entry) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text("${entry.key + 1}. ${entry.value}",
                                style: TextStyle(fontSize: 16)),
                          ))
                      .toList(),
                )
              else
                const Center(child: CircularProgressIndicator()),

              const SizedBox(height: 20),

              // Show Video if Available
              if (_youtubeController != null) ...[
                Text("Watch Recipe Video:",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                YoutubePlayer(
                  controller: _youtubeController!,
                  showVideoProgressIndicator: true,
                ),
              ] else
                const Text("No video available for this recipe."),
            ],
          ),
        ),
      ),
    );
  }
}

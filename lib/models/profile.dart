class Profile {
  String name, imagePath, country, city;
  int followers, post, following;

  Profile(
      {this.name,
      this.imagePath,
      this.country,
      this.city,
      this.followers,
      this.post,
      this.following});
}

final List<Profile> profiles = [
  Profile(
    imagePath: "assets/images/profile1.jpg",
    name: "André Gomez",
    country: "France",
    city: "Nantes",
    post: 135,
    followers: 865,
    following: 495,
  ),
  Profile(
    imagePath: "assets/images/profile2.jpg",
    name: "David Chart",
    country: "Italia",
    city: "Milan",
    post: 255,
    followers: 798,
    following: 563,
  ),
  Profile(
    imagePath: "assets/images/profile3.jpg",
    name: "Jordan Prince",
    country: "EEUU",
    city: "California",
    post: 535,
    followers: 1622,
    following: 325,
  ),
];

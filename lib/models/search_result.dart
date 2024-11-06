class SearchResult {
  final String id;
  final String name;
  final String profileImage;
  final String location;
  final double distance;
  final double rating;
  final int reviewsCount;
  final String bio;
  final int age;
  final List<String> skills;
  final String experience;

  SearchResult({
    required this.id,
    required this.name,
    required this.profileImage,
    required this.location,
    required this.distance,
    required this.rating,
    required this.reviewsCount,
    required this.bio,
    required this.age,
    required this.skills,
    required this.experience
  });


  static List<SearchResult> fetchBabysitters() {
    return [
      SearchResult(
        id: '1',
        name: 'Sarah Johnson',
        profileImage: 'assets/profile/sarah.jpg',
        location: 'New York, NY',
        distance: 2.5,
        rating: 4.8,
        reviewsCount: 25,
        bio: 'Experienced babysitter with a love for children. CPR certified.',
        age: 25,
        skills: ['CPR certified', 'First Aid', 'Bilingual (English/Spanish)'],
        experience: '6 years with newborn and children up to 15 years',
      ),
      SearchResult(
        id: '2',
        name: 'Mike Thompson',
        profileImage: 'assets/profile/mike.jpg',
        location: 'Los Angeles, CA',
        distance: 5.5,
        rating: 4.5,
        reviewsCount: 18,
        bio: 'Fun and energetic babysitter with 5 years of experience.',
        age: 26,
        skills: ['Creative play', 'Cooking', 'Organized activities'],
        experience: '2 years with newborn and children up to 12 years'
      ),
      SearchResult(
        id: '3',
        name: 'Emily Davis',
        profileImage: 'assets/profile/emily.jpg',
        location: 'Chicago, IL',
        distance: 3.5,
        rating: 4.7,
        reviewsCount: 32,
        bio: 'Patient and caring babysitter with a passion for child development.',
        age: 23,
        skills: ['Child psychology', 'Homework help', 'First Aid'],
        experience: '1 year with newborn and children up to 16 years'
      ),
      SearchResult(
        id: '4',
        name: 'David Wilson',
        profileImage: 'assets/profile/david.jpg',
        location: 'San Francisco, CA',
        distance: 6.5,
        rating: 4.6,
        reviewsCount: 28,
        bio: 'Creative babysitter with a background in early childhood education.',
        age: 32,
        skills: ['Arts and crafts', 'Educational games', 'CPR certified'],
        experience: '4 years with newborn and children up to 15 years'
      ),
      SearchResult(
        id: '5',
        name: 'Samantha White',
        profileImage: 'assets/profile/samantha.jpg',
        location: 'Austin, TX',
        distance: 3.5,
        rating: 4.9,
        reviewsCount: 40,
        bio: 'Experienced babysitter with a love for outdoor activities.',
        age: 20,
        skills: ['Swimming', 'Outdoor games', 'Healthy meal prep'],
        experience: '3 years with newborn and children up to 11 years'
      ),
      SearchResult(
        id: '6',
        name: 'Joshua Green',
        profileImage: 'assets/profile/joshua.jpg',
        location: 'Seattle, WA',
        distance: 2.5,
        rating: 4.4,
        reviewsCount: 22,
        bio: 'Friendly and reliable babysitter with 3 years of experience.',
        age: 26,
        skills: ['Storytelling', 'Homework assistance', 'First Aid'],
        experience: '6 years with newborn and children up to 13 years'
      ),
      SearchResult(
        id: '7',
        name: 'Ashley Brown',
        profileImage: 'assets/profile/ashley.jpg',
        location: 'Denver, CO',
        distance: 1.5,
        rating: 4.5,
        reviewsCount: 30,
        bio: 'Energetic babysitter who loves arts and crafts and imaginative play.',
        age: 28,
        skills: ['Creative play', 'Problem-solving', 'Organized activities'],
        experience: '2 years with newborn and children up to 7 years'
      ),
      SearchResult(
        id: '8',
        name: 'Brian Lee',
        profileImage: 'assets/profile/brian.jpg',
        location: 'Portland, OR',
        distance: 3.5,
        rating: 4.7,
        reviewsCount: 27,
        bio: 'Reliable and dedicated babysitter with a background in education.',
        age: 22,
        skills: ['Homework help', 'Sports coaching', 'CPR certified'],
        experience: '4 years with newborn and children up to 17 years'
      ),
      SearchResult(
        id: '9',
        name: 'Olivia Martinez',
        profileImage: 'assets/profile/olivia.jpg',
        location: 'Miami, FL',
        distance: 5.8,
        rating: 4.6,
        reviewsCount: 35,
        bio: 'Bilingual babysitter with experience in toddler and infant care.',
        age: 26,
        skills: ['Bilingual (English/Spanish)', 'Infant care', 'First Aid'],
        experience: '7 years with newborn and children up to 7 years'
      ),
      SearchResult(
        id: '10',
        name: 'James Anderson',
        profileImage: 'assets/profile/james.jpg',
        location: 'Boston, MA',
        distance: 2.7,
        rating: 4.8,
        reviewsCount: 29,
        bio: 'Fun and responsible babysitter with a passion for outdoor adventures.',
        age: 32,
        skills: ['Camping', 'Nature walks', 'First Aid'],
        experience: '6 years with newborn and children up to 5 years'
      ),
      SearchResult(
        id: '11',
        name: 'Megan Clark',
        profileImage: 'assets/profile/megan.jpg',
        location: 'Houston, TX',
        distance: 2.6,
        rating: 4.9,
        reviewsCount: 38,
        bio: 'Caring babysitter with 6 years of experience and a focus on safety.',
        age: 27,
        skills: ['CPR certified', 'Safety protocols', 'First Aid'],
        experience: '4 years with newborn and children up to 9 years'
      ),
      SearchResult(
        id: '12',
        name: 'Ryan Cooper',
        profileImage: 'assets/profile/ryan.jpg',
        location: 'Las Vegas, NV',
        distance: 8.5,
        rating: 4.4,
        reviewsCount: 20,
        bio: 'Responsible babysitter with experience in organizing group activities.',
        age: 20,
        skills: ['Group games', 'Storytelling', 'Meal prep'],
        experience: '1 year with newborn and children up to 12 years'
      ),

    ];
  }
}
class Contact {
  final String name;
  final String image;
  final String phoneNumber;

  const Contact({
    required this.name,
    required this.image,
    required this.phoneNumber,
  });

  static List<Contact> getAllContacts() {
    return [
      const Contact(
        name: 'James',
        image: 'assets/images/people-1.jpg',
        phoneNumber: '+2211555067',
      ),
      const Contact(
        name: 'Mary',
        image: 'assets/images/people-2.jpg',
        phoneNumber: '+3351155637',
      ),
      const Contact(
        name: 'Harris',
        image: 'assets/images/people-3.jpg',
        phoneNumber: '+4457788890',
      ),
      const Contact(
        name: 'Jacky',
        image: 'assets/images/people-4.jpg',
        phoneNumber: '+987780035',
      ),
      const Contact(
        name: 'Hugo',
        image: 'assets/images/people-5.jpg',
        phoneNumber: '+9988776655',
      ),
    ];
  }
}
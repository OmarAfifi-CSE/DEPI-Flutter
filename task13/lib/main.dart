import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Hotel Animations',
      debugShowCheckedModeBanner: false,
      home: HotelBookingScreen(),
    );
  }
}

class HotelBookingScreen extends StatefulWidget {
  const HotelBookingScreen({super.key});

  @override
  State<HotelBookingScreen> createState() => _HotelBookingScreenState();
}

class _HotelBookingScreenState extends State<HotelBookingScreen>
    with TickerProviderStateMixin {
  bool _isExpanded = false;
  int _selectedTab = 0;
  double _price = 5000.0;
  late TabController _tabController;
  final TextEditingController _priceController = TextEditingController();

  late AnimationController _priceAnimationController;
  late Animation<double> _priceAnimation;
  late AnimationController _buttonAnimationController;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _selectedTab = _tabController.index;
        });
      }
    });

    _priceController.text = _price.toInt().toString();

    _priceAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _priceAnimation = Tween<double>(
      begin: _price,
      end: _price,
    ).animate(_priceAnimationController);

    _buttonAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ), // Duration for the whole sequence
    );

    _buttonScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: 0.9,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 40.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.9,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 60.0,
      ),
    ]).animate(_buttonAnimationController);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _priceController.dispose();
    _priceAnimationController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  void _updatePriceFromTextField() {
    final double oldPrice = _price;
    final newPrice = double.tryParse(_priceController.text.trim()) ?? _price;
    final clampedPrice = newPrice.clamp(1.0, 10000.0);

    setState(() {
      _price = clampedPrice;
    });

    _priceAnimation = Tween<double>(begin: oldPrice, end: clampedPrice).animate(
      CurvedAnimation(
        parent: _priceAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _priceAnimationController.forward(from: 0.0);
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      appBar: AppBar(
        title: const Text(
          'Smart Hotel Booking',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF6F7F8),
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: const Color(0xFFF6F7F8),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHotelCard(),
              const SizedBox(height: 20),
              _buildTabs(),
              const SizedBox(height: 20),
              _buildTabContent(),
              const SizedBox(height: 24),
              _buildPriceSlider(),
              const SizedBox(height: 30),
              _buildBookNowButton(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.business_center),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildHotelCard() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        height: _isExpanded ? 365 : 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(_isExpanded ? 6 : 24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_isExpanded ? 6 : 24),
          child: _isExpanded
              ? SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/Hotel-Image-Expanded.png",
                        height: 240,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Grand Hyatt Manila',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.star, color: Colors.amber, size: 16),
                                Icon(Icons.star, color: Colors.amber, size: 16),
                                Icon(Icons.star, color: Colors.amber, size: 16),
                                Icon(Icons.star, color: Colors.amber, size: 16),
                                Icon(
                                  Icons.star_border,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                              ],
                            ),
                            Text(
                              'Deluxe King Room',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Deluxe King Roome a to din I Ansor',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Image.asset(
                  "assets/images/Hotel-Image.png",
                  height: 180,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TabBar(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        controller: _tabController,
        dividerColor: Colors.transparent,
        indicatorPadding: const EdgeInsets.all(5.0),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.blue,
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withAlpha(77),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        labelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        unselectedLabelColor: Colors.black54,
        tabs: const [
          Tab(text: 'Offers'),
          Tab(text: 'Guest Reviews'),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: _selectedTab == 0 ? _buildOffersContent() : _buildReviewsContent(),
    );
  }

  Widget _buildOffersContent() {
    return Container(
      key: const ValueKey('offers'),
      height: 180,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.all(Radius.circular(24)),
        image: DecorationImage(
          image: AssetImage("assets/images/Offers-Image.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "20% off this weekend!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Book now and save big on your stay.",
              style: TextStyle(color: Color(0xffE2E8F0), fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsContent() {
    return Card(
      key: const ValueKey('reviews'),
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "John D.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Icon(Icons.star_border, color: Colors.amber, size: 16),
                      ],
                    ),
                  ],
                ),
                Text(
                  "Amazing stay, highly recommend the spa!",
                  style: TextStyle(fontSize: 14, color: Color(0xff475569)),
                ),
              ],
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sarah K.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Icon(Icons.star_border, color: Colors.amber, size: 16),
                        Icon(Icons.star_border, color: Colors.amber, size: 16),
                      ],
                    ),
                  ],
                ),
                Text(
                  "Great service, room was very clean.",
                  style: TextStyle(fontSize: 14, color: Color(0xff475569)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Price Range:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _priceController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 5,
            ),
            prefixText: '\$ ',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            suffixIcon: IconButton(
              icon: const Icon(Icons.arrow_circle_right_outlined),
              onPressed: _updatePriceFromTextField,
            ),
          ),
          onSubmitted: (_) => _updatePriceFromTextField(),
        ),
        const SizedBox(height: 12),
        AnimatedBuilder(
          animation: _priceAnimation,
          builder: (context, child) {
            return Column(
              children: [
                Slider(
                  value: _priceAnimation.value,
                  activeColor: Colors.blue,
                  thumbColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  min: 1,
                  max: 10000,
                  label: '\$${_priceAnimation.value.round()}',
                  onChanged: (newPrice) {
                    _priceAnimationController.stop();
                    setState(() {
                      _price = newPrice;
                      _priceAnimation = Tween<double>(
                        begin: newPrice,
                        end: newPrice,
                      ).animate(_priceAnimationController);
                      _priceController.text = newPrice.toInt().toString();
                    });
                  },
                ),
                child!,
              ],
            );
          },
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('\$1'), Text('\$10K')],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookNowButton() {
    return ScaleTransition(
      scale: _buttonScaleAnimation,
      child: ElevatedButton(
        onPressed: () {
          _buttonAnimationController.forward(from: 0.0);
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          'Book Now',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

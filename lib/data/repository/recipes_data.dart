import '../models/diet_type.dart';
import '../models/ingredient.dart';
import '../models/localized_text.dart';
import '../models/recipe.dart';
import '../models/recipe_step.dart';
import 'meat_chicken_recipes.dart';
import 'recipe_tags.dart';
import 'tagine_recipes.dart';

typedef _T = LocalizedText;
typedef _Tag = RecipeTags;

const _img = 'https://www.themealdb.com/images/media/meals';

/// The static data pool of recipes available in the app.
///
/// All content is bilingual (English / Arabic). Step durations are the base
/// (intermediate) times; they are scaled at runtime by the cook level.
const List<Recipe> recipesData = [
  // ───────────────────────────── Egyptian ─────────────────────────────
  Recipe(
    id: 'koshari',
    name: _T('Koshari', 'كشري'),
    description: _T(
      "Egypt's national dish: rice, lentils and pasta topped with a tangy "
          'spiced tomato sauce, garlic vinegar and crispy fried onions.',
      'أكلة مصر الشعبية: رز وعدس ومكرونة، عليهم صلصة طماطم متبلة ودقة '
          'بالخل والتوم وبصل مقرمش.',
    ),
    imageUrl: '$_img/4er7mj1598733193.jpg',
    tags: [_Tag.egyptian, _Tag.rice, _Tag.pasta, _Tag.lentils],
    diet: DietType.plant,
    servings: 4,
    isTodaysChallenge: true,
    ingredients: [
      Ingredient(name: _T('Rice', 'رز'), quantity: _T('1 cup', 'كوباية')),
      Ingredient(
        name: _T('Brown lentils', 'عدس بجبة'),
        quantity: _T('1 cup', 'كوباية'),
      ),
      Ingredient(
        name: _T('Elbow pasta', 'مكرونة كوع'),
        quantity: _T('250 g', '٢٥٠ جرام'),
      ),
      Ingredient(name: _T('Onions', 'بصل'), quantity: _T('3 large', '٣ كبار')),
      Ingredient(
        name: _T('Tomato sauce', 'صلصة طماطم'),
        quantity: _T('400 g', '٤٠٠ جرام'),
      ),
      Ingredient(name: _T('Garlic cloves', 'فصوص توم'), quantity: _T('6', '٦')),
      Ingredient(
        name: _T('White vinegar', 'خل أبيض'),
        quantity: _T('3 tbsp', '٣ معالق كبيرة'),
      ),
      Ingredient(
        name: _T('Cumin & chili', 'كمون وشطة'),
        quantity: _T('To taste', 'حسب الرغبة'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Fry the onions', 'حمّر البصل'),
        description: _T(
          'Slice the onions thinly and fry in plenty of oil until deep golden '
              'and crispy. Keep the oil for later.',
          'قطّع البصل شرايح رفيعة وحمّره في زيت كتير لحد ما يبقى دهبي ومقرمش. '
              'احتفظ بالزيت.',
        ),
        baseDuration: Duration(minutes: 15),
      ),
      RecipeStep(
        title: _T('Cook the lentils', 'سلق العدس'),
        description: _T(
          'Boil the lentils in salted water until tender but still whole.',
          'اسلق العدس في مية بملح لحد ما يستوي من غير ما يتهرس.',
        ),
        baseDuration: Duration(minutes: 15),
      ),
      RecipeStep(
        title: _T('Cook the rice', 'طبخ الرز'),
        description: _T(
          'Toast the rice in the onion oil, add the lentils and water and '
              'simmer covered until fluffy.',
          'شوّح الرز في زيت البصل، ضيف العدس والمية وسيبه على نار هادية لحد '
              'ما يستوي.',
        ),
        baseDuration: Duration(minutes: 15),
      ),
      RecipeStep(
        title: _T('Boil the pasta', 'سلق المكرونة'),
        description: _T(
          'Cook the pasta in salted water until al dente, then drain.',
          'اسلق المكرونة في مية بملح لحد ما تستوي وصفّيها.',
        ),
        baseDuration: Duration(minutes: 10),
      ),
      RecipeStep(
        title: _T('Make the sauce & daqqa', 'الصلصة والدقة'),
        description: _T(
          'Fry garlic, add tomato sauce, cumin, chili and a splash of vinegar '
              'and simmer. Mix garlic, vinegar and water for the daqqa.',
          'شوّح التوم، ضيف الصلصة والكمون والشطة وشوية خل وسيبها تتسبك. '
              'اخلط توم وخل ومية للدقة.',
        ),
        baseDuration: Duration(minutes: 10),
      ),
      RecipeStep(
        title: _T('Assemble', 'التجميع'),
        description: _T(
          'Layer rice and lentils, pasta, sauce, daqqa and top with the '
              'crispy onions.',
          'حط الرز بالعدس، وبعدين المكرونة والصلصة والدقة، ووشّها بالبصل '
              'المحمر.',
        ),
        baseDuration: Duration(minutes: 5),
      ),
    ],
  ),
  Recipe(
    id: 'ful-medames',
    name: _T('Ful Medames', 'فول مدمس'),
    description: _T(
      'Slow-cooked fava beans mashed with cumin, lemon and olive oil. The '
          'classic Egyptian breakfast.',
      'فول مدمس متهرس بالكمون والليمون والزيت. الفطار المصري الأصلي.',
    ),
    imageUrl: '$_img/lvn2d51598732465.jpg',
    tags: [_Tag.egyptian, _Tag.beans, _Tag.breakfast],
    diet: DietType.plant,
    servings: 3,
    ingredients: [
      Ingredient(
        name: _T('Cooked fava beans', 'فول مدمس'),
        quantity: _T('2 cans', '٢ علبة'),
      ),
      Ingredient(name: _T('Garlic cloves', 'فصوص توم'), quantity: _T('2', '٢')),
      Ingredient(name: _T('Lemon', 'ليمون'), quantity: _T('1', 'واحدة')),
      Ingredient(
        name: _T('Cumin', 'كمون'),
        quantity: _T('1 tsp', 'معلقة صغيرة'),
      ),
      Ingredient(
        name: _T('Olive oil', 'زيت زيتون'),
        quantity: _T('3 tbsp', '٣ معالق كبيرة'),
      ),
      Ingredient(
        name: _T('Tomato & parsley', 'طماطم وبقدونس'),
        quantity: _T('To garnish', 'للتزيين'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Heat the beans', 'سخّن الفول'),
        description: _T(
          'Warm the beans with a little of their liquid over medium heat.',
          'سخّن الفول بشوية من ميته على نار متوسطة.',
        ),
        baseDuration: Duration(minutes: 8),
      ),
      RecipeStep(
        title: _T('Mash & season', 'هرس وتتبيل'),
        description: _T(
          'Mash with crushed garlic, cumin, salt and lemon juice.',
          'اهرس الفول بالتوم المدقوق والكمون والملح وعصير الليمون.',
        ),
        baseDuration: Duration(minutes: 5),
      ),
      RecipeStep(
        title: _T('Garnish & serve', 'التزيين والتقديم'),
        description: _T(
          'Drizzle with olive oil, top with tomato and parsley and serve with '
              'baladi bread.',
          'حط زيت زيتون ووشّه بالطماطم والبقدونس وقدّمه مع العيش البلدي.',
        ),
        baseDuration: Duration(minutes: 3),
      ),
    ],
  ),
  Recipe(
    id: 'taameya',
    name: _T("Ta'ameya", 'طعمية'),
    description: _T(
      'Egyptian falafel made from fava beans and lots of fresh herbs, crispy '
          'outside and bright green inside.',
      'الطعمية المصرية بالفول والخضرة، مقرمشة من بره وخضرا من جوه.',
    ),
    imageUrl: '$_img/n3xxd91598732796.jpg',
    tags: [_Tag.egyptian, _Tag.vegan, _Tag.breakfast],
    diet: DietType.plant,
    servings: 4,
    ingredients: [
      Ingredient(
        name: _T('Soaked split fava beans', 'فول مدشوش منقوع'),
        quantity: _T('2 cups', '٢ كوباية'),
      ),
      Ingredient(
        name: _T('Dill, parsley & coriander', 'شبت وبقدونس وكزبرة'),
        quantity: _T('1 bunch each', 'حزمة من كل نوع'),
      ),
      Ingredient(
        name: _T('Onion & leek', 'بصل وكرات'),
        quantity: _T('1 each', 'واحدة من كل نوع'),
      ),
      Ingredient(name: _T('Garlic cloves', 'فصوص توم'), quantity: _T('4', '٤')),
      Ingredient(
        name: _T('Sesame seeds', 'سمسم'),
        quantity: _T('2 tbsp', '٢ معلقة كبيرة'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Grind the mix', 'طحن الخلطة'),
        description: _T(
          'Grind the beans with the herbs, onion, leek and garlic into a '
              'smooth green paste.',
          'افرم الفول مع الخضرة والبصل والكرات والتوم لحد ما تبقى عجينة خضرا '
              'ناعمة.',
        ),
        baseDuration: Duration(minutes: 10),
      ),
      RecipeStep(
        title: _T('Season & rest', 'التتبيل والراحة'),
        description: _T(
          'Add salt, cumin, coriander powder and a pinch of baking soda. Rest '
              'for a few minutes.',
          'ضيف ملح وكمون وكزبرة ناشفة ورشة بيكربونات وسيبها ترتاح شوية.',
        ),
        baseDuration: Duration(minutes: 8),
      ),
      RecipeStep(
        title: _T('Shape & fry', 'التشكيل والقلي'),
        description: _T(
          'Shape small discs, sprinkle with sesame and fry in hot oil until '
              'golden.',
          'شكّل أقراص صغيرة، رش عليها سمسم واقليها في زيت سخن لحد ما تحمر.',
        ),
        baseDuration: Duration(minutes: 15),
      ),
    ],
  ),
  Recipe(
    id: 'molokhia',
    name: _T('Molokhia with Chicken', 'ملوخية بالفراخ'),
    description: _T(
      'Silky jute leaf soup cooked in rich chicken broth with a sizzling '
          'garlic and coriander taqliya.',
      'ملوخية خضرا في شوربة فراخ غنية مع طشة التوم والكزبرة.',
    ),
    imageUrl: '$_img/x372ug1598733932.jpg',
    tags: [_Tag.egyptian, _Tag.chicken, _Tag.soup],
    diet: DietType.meat,
    servings: 4,
    ingredients: [
      Ingredient(name: _T('Whole chicken', 'فرخة'), quantity: _T('1', 'واحدة')),
      Ingredient(
        name: _T('Minced molokhia', 'ملوخية مخروطة'),
        quantity: _T('400 g', '٤٠٠ جرام'),
      ),
      Ingredient(name: _T('Garlic cloves', 'فصوص توم'), quantity: _T('8', '٨')),
      Ingredient(
        name: _T('Ground coriander', 'كزبرة ناشفة'),
        quantity: _T('1 tbsp', 'معلقة كبيرة'),
      ),
      Ingredient(
        name: _T('Ghee', 'سمنة'),
        quantity: _T('2 tbsp', '٢ معلقة كبيرة'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Make the broth', 'عمل الشوربة'),
        description: _T(
          'Boil the chicken with onion, cardamom and bay leaf until tender. '
              'Strain the broth.',
          'اسلق الفرخة ببصل وحبهان وورق لورا لحد ما تستوي وصفّي الشوربة.',
        ),
        baseDuration: Duration(minutes: 35),
      ),
      RecipeStep(
        title: _T('Roast the chicken', 'تحمير الفراخ'),
        description: _T(
          'Brush the chicken with ghee and spices and roast until golden.',
          'ادهن الفرخة بالسمنة والبهارات وحمّرها في الفرن.',
        ),
        baseDuration: Duration(minutes: 15),
      ),
      RecipeStep(
        title: _T('Cook the molokhia', 'طبخ الملوخية'),
        description: _T(
          'Bring the broth to a boil, add the molokhia and stir until it just '
              'simmers. Do not overboil.',
          'غلّي الشوربة، ضيف الملوخية وقلّب لحد ما تغلي غلوة واحدة بس.',
        ),
        baseDuration: Duration(minutes: 7),
      ),
      RecipeStep(
        title: _T('The taqliya', 'الطشة'),
        description: _T(
          'Fry crushed garlic and coriander in ghee until golden and pour '
              'into the molokhia.',
          'حمّر التوم المدقوق والكزبرة في السمنة وطشهم على الملوخية.',
        ),
        baseDuration: Duration(minutes: 5),
      ),
    ],
  ),
  Recipe(
    id: 'fatteh',
    name: _T('Egyptian Fatteh', 'فتة مصري'),
    description: _T(
      'Crispy bread and rice layered with tender meat, drenched in a garlic '
          'vinegar tomato sauce. A feast dish.',
      'عيش محمص ورز ولحمة طرية مع صلصة الخل والتوم. أكلة العزايم والأعياد.',
    ),
    imageUrl: '$_img/rlwcc51598734603.jpg',
    tags: [_Tag.egyptian, _Tag.meat, _Tag.rice, _Tag.bread],
    diet: DietType.meat,
    servings: 6,
    ingredients: [
      Ingredient(
        name: _T('Beef or lamb', 'لحمة بتلو أو ضاني'),
        quantity: _T('1 kg', 'كيلو'),
      ),
      Ingredient(
        name: _T('Egyptian rice', 'رز مصري'),
        quantity: _T('2 cups', '٢ كوباية'),
      ),
      Ingredient(
        name: _T('Baladi bread', 'عيش بلدي'),
        quantity: _T('3 loaves', '٣ أرغفة'),
      ),
      Ingredient(
        name: _T('Garlic cloves', 'فصوص توم'),
        quantity: _T('10', '١٠'),
      ),
      Ingredient(
        name: _T('Vinegar', 'خل'),
        quantity: _T('1/3 cup', 'تلت كوباية'),
      ),
      Ingredient(
        name: _T('Tomato sauce', 'صلصة طماطم'),
        quantity: _T('2 cups', '٢ كوباية'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Boil the meat', 'سلق اللحمة'),
        description: _T(
          'Boil the meat with onion, cardamom and bay leaves until tender. '
              'Keep the broth.',
          'اسلق اللحمة ببصل وحبهان وورق لورا لحد ما تستوي واحتفظ بالشوربة.',
        ),
        baseDuration: Duration(minutes: 40),
      ),
      RecipeStep(
        title: _T('Cook the rice', 'طبخ الرز'),
        description: _T(
          'Cook the rice in some of the broth with a spoon of ghee.',
          'اطبخ الرز بشوية من الشوربة ومعلقة سمنة.',
        ),
        baseDuration: Duration(minutes: 20),
      ),
      RecipeStep(
        title: _T('Toast the bread', 'تحميص العيش'),
        description: _T(
          'Cut the bread into pieces and toast in the oven with ghee until '
              'crunchy.',
          'قطّع العيش حتت وحمّصه في الفرن بالسمنة لحد ما يقرمش.',
        ),
        baseDuration: Duration(minutes: 10),
      ),
      RecipeStep(
        title: _T('Garlic vinegar sauce', 'صلصة الخل والتوم'),
        description: _T(
          'Fry garlic in ghee, add vinegar, then tomato sauce and simmer.',
          'حمّر التوم في السمنة، ضيف الخل وبعدين الصلصة وسيبها تتسبك.',
        ),
        baseDuration: Duration(minutes: 10),
      ),
      RecipeStep(
        title: _T('Layer the fatteh', 'رص الفتة'),
        description: _T(
          'Bread soaked in broth, then rice, sauce and the meat on top.',
          'العيش مبلول بالشوربة، وبعدين الرز والصلصة واللحمة على الوش.',
        ),
        baseDuration: Duration(minutes: 5),
      ),
    ],
  ),
  Recipe(
    id: 'feteer-meshaltet',
    name: _T('Feteer Meshaltet', 'فطير مشلتت'),
    description: _T(
      'Flaky, buttery layered pastry from the Egyptian countryside, served '
          'with honey or old cheese.',
      'فطير فلاحي بطبقات السمنة، بيتقدم بالعسل أو الجبنة القديمة.',
    ),
    imageUrl: '$_img/9f4z6v1598734293.jpg',
    tags: [_Tag.egyptian, _Tag.sweet, _Tag.breakfast],
    diet: DietType.plant,
    servings: 6,
    ingredients: [
      Ingredient(
        name: _T('Flour', 'دقيق'),
        quantity: _T('4 cups', '٤ كوبايات'),
      ),
      Ingredient(
        name: _T('Warm water', 'مية دافية'),
        quantity: _T('1.5 cups', 'كوباية ونص'),
      ),
      Ingredient(
        name: _T('Ghee & butter', 'سمنة وزبدة'),
        quantity: _T('1 cup', 'كوباية'),
      ),
      Ingredient(name: _T('Salt', 'ملح'), quantity: _T('1 tsp', 'معلقة صغيرة')),
    ],
    steps: [
      RecipeStep(
        title: _T('Knead the dough', 'عجن العجينة'),
        description: _T(
          'Knead flour, salt and water into a very soft, elastic dough.',
          'اعجن الدقيق والملح والمية لحد ما تبقى عجينة طرية جدًا ومطاطة.',
        ),
        baseDuration: Duration(minutes: 12),
      ),
      RecipeStep(
        title: _T('Rest in ghee', 'الراحة في السمنة'),
        description: _T(
          'Divide into balls, coat with ghee and let them rest.',
          'قسّمها كور، غطّيها بالسمنة وسيبها ترتاح.',
        ),
        baseDuration: Duration(minutes: 20),
      ),
      RecipeStep(
        title: _T('Stretch & fold', 'الفرد والتطبيق'),
        description: _T(
          'Stretch each ball paper-thin, brush with ghee and fold into layers.',
          'افرد كل كورة لحد ما تبقى رفيعة زي الورق، ادهنها سمنة وطبّقها طبقات.',
        ),
        baseDuration: Duration(minutes: 15),
      ),
      RecipeStep(
        title: _T('Bake', 'الخبز'),
        description: _T(
          'Bake in a very hot oven until puffed and golden.',
          'ادخله فرن سخن جدًا لحد ما ينفش ويحمر.',
        ),
        baseDuration: Duration(minutes: 25),
      ),
    ],
  ),
  Recipe(
    id: 'chicken-shawarma',
    name: _T('Chicken Shawarma', 'شاورما فراخ'),
    description: _T(
      'Spiced chicken strips seared until charred, wrapped in bread with '
          'garlic toum and pickles.',
      'شرايح فراخ متبلة ومحمرة، ملفوفة في عيش مع التومية والمخلل.',
    ),
    imageUrl: '$_img/kcv6hj1598733479.jpg',
    tags: [_Tag.egyptian, _Tag.chicken, _Tag.bread],
    diet: DietType.meat,
    servings: 4,
    ingredients: [
      Ingredient(
        name: _T('Chicken thighs', 'أوراك فراخ'),
        quantity: _T('600 g', '٦٠٠ جرام'),
      ),
      Ingredient(
        name: _T('Shawarma spices', 'بهارات شاورما'),
        quantity: _T('2 tbsp', '٢ معلقة كبيرة'),
      ),
      Ingredient(
        name: _T('Yogurt', 'زبادي'),
        quantity: _T('3 tbsp', '٣ معالق كبيرة'),
      ),
      Ingredient(
        name: _T('Garlic sauce', 'تومية'),
        quantity: _T('1/2 cup', 'نص كوباية'),
      ),
      Ingredient(name: _T('Pita bread', 'عيش شامي'), quantity: _T('4', '٤')),
    ],
    steps: [
      RecipeStep(
        title: _T('Marinate', 'التتبيل'),
        description: _T(
          'Slice the chicken and marinate with yogurt, lemon and spices.',
          'قطّع الفراخ شرايح وتبّلها بالزبادي والليمون والبهارات.',
        ),
        baseDuration: Duration(minutes: 10),
      ),
      RecipeStep(
        title: _T('Sear', 'التحمير'),
        description: _T(
          'Cook in a very hot pan until charred at the edges.',
          'حمّرها في طاسة سخنة جدًا لحد ما أطرافها تتشوط.',
        ),
        baseDuration: Duration(minutes: 12),
      ),
      RecipeStep(
        title: _T('Wrap', 'اللف'),
        description: _T(
          'Spread toum on the bread, add chicken and pickles and roll tightly.',
          'افرد التومية على العيش، حط الفراخ والمخلل ولفّها كويس.',
        ),
        baseDuration: Duration(minutes: 5),
      ),
    ],
  ),
  Recipe(
    id: 'mesaqaa',
    name: _T("Egyptian Mesaqa'a", 'مسقعة'),
    description: _T(
      'Fried eggplant baked in a garlicky tomato and pepper sauce. Simple, '
          'rich and comforting.',
      'باذنجان مقلي متسبك في صلصة طماطم بالتوم والفلفل. أكلة بيتي دافية.',
    ),
    imageUrl: '$_img/ctg8jd1585563097.jpg',
    tags: [_Tag.egyptian, _Tag.vegetables, _Tag.tomato],
    diet: DietType.plant,
    servings: 4,
    ingredients: [
      Ingredient(name: _T('Eggplants', 'باذنجان رومي'), quantity: _T('3', '٣')),
      Ingredient(
        name: _T('Green peppers', 'فلفل أخضر'),
        quantity: _T('2', '٢'),
      ),
      Ingredient(
        name: _T('Tomato sauce', 'صلصة طماطم'),
        quantity: _T('2 cups', '٢ كوباية'),
      ),
      Ingredient(name: _T('Garlic cloves', 'فصوص توم'), quantity: _T('4', '٤')),
      Ingredient(name: _T('Chili', 'شطة'), quantity: _T('Optional', 'اختياري')),
    ],
    steps: [
      RecipeStep(
        title: _T('Fry the eggplant', 'قلي الباذنجان'),
        description: _T(
          'Slice the eggplant into rounds, salt them and fry until golden.',
          'قطّع الباذنجان حلقات، رش ملح واقليه لحد ما يحمر.',
        ),
        baseDuration: Duration(minutes: 18),
      ),
      RecipeStep(
        title: _T('Make the sauce', 'عمل الصلصة'),
        description: _T(
          'Sauté garlic and peppers, add the tomato sauce and spices and '
              'simmer.',
          'شوّح التوم والفلفل، ضيف الصلصة والبهارات وسيبها تتسبك.',
        ),
        baseDuration: Duration(minutes: 12),
      ),
      RecipeStep(
        title: _T('Layer & bake', 'الرص والتسوية'),
        description: _T(
          'Layer the eggplant in a tray, pour over the sauce and bake.',
          'رص الباذنجان في صينية، صب عليه الصلصة وادخله الفرن.',
        ),
        baseDuration: Duration(minutes: 20),
      ),
    ],
  ),
  Recipe(
    id: 'mahshi-felfel',
    name: _T('Stuffed Peppers (Mahshi)', 'محشي فلفل'),
    description: _T(
      'Bell peppers stuffed with herby rice and simmered in tomato broth, '
          'a beloved Egyptian family dish.',
      'فلفل رومي محشي رز بالخضرة ومتسبك في صلصة الطماطم. أكلة العيلة.',
    ),
    imageUrl: '$_img/w0rsga1782683912.jpg',
    tags: [_Tag.egyptian, _Tag.rice, _Tag.vegetables],
    diet: DietType.plant,
    servings: 4,
    ingredients: [
      Ingredient(name: _T('Bell peppers', 'فلفل رومي'), quantity: _T('8', '٨')),
      Ingredient(
        name: _T('Egyptian rice', 'رز مصري'),
        quantity: _T('2 cups', '٢ كوباية'),
      ),
      Ingredient(
        name: _T('Dill, parsley & coriander', 'شبت وبقدونس وكزبرة'),
        quantity: _T('1 bunch each', 'حزمة من كل نوع'),
      ),
      Ingredient(
        name: _T('Tomato juice', 'عصير طماطم'),
        quantity: _T('3 cups', '٣ كوبايات'),
      ),
      Ingredient(name: _T('Onion', 'بصل'), quantity: _T('1', 'واحدة')),
    ],
    steps: [
      RecipeStep(
        title: _T('Prepare the filling', 'تجهيز الحشو'),
        description: _T(
          'Mix the rice with chopped herbs, grated onion, tomato, salt and '
              'spices.',
          'اخلط الرز بالخضرة المفرومة والبصل المبشور والطماطم والملح والبهارات.',
        ),
        baseDuration: Duration(minutes: 12),
      ),
      RecipeStep(
        title: _T('Hollow the peppers', 'تفريغ الفلفل'),
        description: _T(
          'Cut off the tops and remove the seeds.',
          'اقطع راس الفلفل وشيل البذر.',
        ),
        baseDuration: Duration(minutes: 8),
      ),
      RecipeStep(
        title: _T('Stuff', 'الحشو'),
        description: _T(
          'Fill each pepper three-quarters full so the rice can expand.',
          'احشي كل فلفلاية لحد تلاتة أرباعها عشان الرز يفرد.',
        ),
        baseDuration: Duration(minutes: 12),
      ),
      RecipeStep(
        title: _T('Simmer', 'التسوية'),
        description: _T(
          'Arrange in a pot, cover with tomato broth and simmer until the rice '
              'is cooked.',
          'رصّهم في حلة، غطّيهم بالصلصة وسيبهم على نار هادية لحد ما الرز يستوي.',
        ),
        baseDuration: Duration(minutes: 35),
      ),
    ],
  ),

  // ──────────────────────── Meat & chicken dishes ────────────────────────
  ...meatAndChickenRecipes,

  // ──────────────────────────── Tagines (طواجن) ───────────────────────────
  ...tagineRecipes,

  // ──────────────────────────── International ───────────────────────────
  Recipe(
    id: 'chicken-noodle-stir-fry',
    name: _T('Chicken Noodle Stir Fry', 'نودلز بالفراخ'),
    description: _T(
      'A fast, high-heat wok dish with tender chicken, crisp vegetables and '
          'chewy noodles tossed in a glossy soy-ginger sauce.',
      'طبق سريع على نار عالية: فراخ طرية وخضار مقرمش ونودلز في صوص الصويا '
          'والجنزبيل.',
    ),
    imageUrl: '$_img/uuuspp1468263334.jpg',
    tags: [_Tag.chicken, _Tag.vegetables, _Tag.pasta],
    diet: DietType.meat,
    servings: 2,
    ingredients: [
      Ingredient(
        name: _T('Egg noodles', 'نودلز'),
        quantity: _T('250 g', '٢٥٠ جرام'),
      ),
      Ingredient(
        name: _T('Chicken breast', 'صدور فراخ'),
        quantity: _T('300 g', '٣٠٠ جرام'),
      ),
      Ingredient(
        name: _T('Bell pepper', 'فلفل رومي'),
        quantity: _T('1', 'واحدة'),
      ),
      Ingredient(
        name: _T('Broccoli florets', 'بروكلي'),
        quantity: _T('1 cup', 'كوباية'),
      ),
      Ingredient(
        name: _T('Soy sauce', 'صويا صوص'),
        quantity: _T('3 tbsp', '٣ معالق كبيرة'),
      ),
      Ingredient(
        name: _T('Fresh ginger', 'جنزبيل فريش'),
        quantity: _T('1 tbsp', 'معلقة كبيرة'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Prep the ingredients', 'تجهيز المكونات'),
        description: _T(
          'Slice the chicken into thin strips and cut the vegetables into '
              'bite-sized pieces.',
          'قطّع الفراخ شرايح رفيعة والخضار حتت صغيرة.',
        ),
        baseDuration: Duration(minutes: 12),
      ),
      RecipeStep(
        title: _T('Cook the noodles', 'سلق النودلز'),
        description: _T(
          'Boil the noodles until just tender, drain and toss with a little '
              'oil.',
          'اسلق النودلز لحد ما تستوي، صفّيها وقلّبها بشوية زيت.',
        ),
        baseDuration: Duration(minutes: 8),
      ),
      RecipeStep(
        title: _T('Sear the chicken', 'تحمير الفراخ'),
        description: _T(
          'Stir fry the chicken in a smoking hot wok until golden.',
          'شوّح الفراخ في طاسة سخنة جدًا لحد ما تحمر.',
        ),
        baseDuration: Duration(minutes: 10),
      ),
      RecipeStep(
        title: _T('Toss everything together', 'قلّب كل حاجة مع بعض'),
        description: _T(
          'Stir fry the vegetables, return the chicken and noodles, add the '
              'soy sauce and toss until glossy.',
          'شوّح الخضار، رجّع الفراخ والنودلز، ضيف الصويا وقلّب لحد ما تلمع.',
        ),
        baseDuration: Duration(minutes: 10),
      ),
    ],
  ),
  Recipe(
    id: 'chicken-alfredo',
    name: _T('Chicken Alfredo', 'فيتوتشيني ألفريدو بالفراخ'),
    description: _T(
      'Creamy parmesan sauce coating fettuccine and pan-seared chicken.',
      'صوص كريمة وبارميزان على مكرونة فيتوتشيني وفراخ محمرة.',
    ),
    imageUrl: '$_img/syqypv1486981727.jpg',
    tags: [_Tag.chicken, _Tag.pasta, _Tag.sauce],
    diet: DietType.meat,
    servings: 4,
    ingredients: [
      Ingredient(
        name: _T('Fettuccine', 'فيتوتشيني'),
        quantity: _T('400 g', '٤٠٠ جرام'),
      ),
      Ingredient(
        name: _T('Chicken breast', 'صدور فراخ'),
        quantity: _T('2', '٢'),
      ),
      Ingredient(
        name: _T('Heavy cream', 'كريمة طبخ'),
        quantity: _T('300 ml', '٣٠٠ مل'),
      ),
      Ingredient(
        name: _T('Parmesan', 'بارميزان'),
        quantity: _T('80 g', '٨٠ جرام'),
      ),
      Ingredient(name: _T('Garlic cloves', 'فصوص توم'), quantity: _T('3', '٣')),
    ],
    steps: [
      RecipeStep(
        title: _T('Season & sear the chicken', 'تتبيل وتحمير الفراخ'),
        description: _T(
          'Season the chicken and cook 6-7 minutes per side. Rest and slice.',
          'تبّل الفراخ وحمّرها ٦-٧ دقايق كل ناحية، وبعدين قطّعها.',
        ),
        baseDuration: Duration(minutes: 12),
      ),
      RecipeStep(
        title: _T('Cook the pasta', 'سلق المكرونة'),
        description: _T(
          'Cook the fettuccine until al dente. Reserve a cup of water.',
          'اسلق المكرونة واحتفظ بكوباية من ميتها.',
        ),
        baseDuration: Duration(minutes: 10),
      ),
      RecipeStep(
        title: _T('Make the sauce', 'عمل الصوص'),
        description: _T(
          'Sauté garlic in butter, add cream and simmer, then melt in the '
              'parmesan.',
          'شوّح التوم في الزبدة، ضيف الكريمة، وبعدين دوّب البارميزان.',
        ),
        baseDuration: Duration(minutes: 8),
      ),
      RecipeStep(
        title: _T('Combine and serve', 'التجميع والتقديم'),
        description: _T(
          'Toss the pasta and chicken in the sauce, loosening with pasta '
              'water.',
          'قلّب المكرونة والفراخ في الصوص وخففه بمية المكرونة لو محتاج.',
        ),
        baseDuration: Duration(minutes: 5),
      ),
    ],
  ),
  Recipe(
    id: 'fried-rice',
    name: _T('Fried Rice', 'رز مقلي'),
    description: _T(
      'Day-old rice stir fried with egg, vegetables and soy sauce.',
      'رز بايت متشوح بالبيض والخضار وصوص الصويا.',
    ),
    imageUrl: '$_img/wuyd2h1765655837.jpg',
    tags: [_Tag.rice, _Tag.vegetables, _Tag.eggs],
    diet: DietType.plant,
    servings: 2,
    ingredients: [
      Ingredient(
        name: _T('Cooked rice', 'رز مطبوخ'),
        quantity: _T('3 cups', '٣ كوبايات'),
      ),
      Ingredient(name: _T('Eggs', 'بيض'), quantity: _T('2', '٢')),
      Ingredient(
        name: _T('Peas & carrots', 'بسلة وجزر'),
        quantity: _T('1 cup', 'كوباية'),
      ),
      Ingredient(
        name: _T('Soy sauce', 'صويا صوص'),
        quantity: _T('2 tbsp', '٢ معلقة كبيرة'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Scramble the eggs', 'سوّي البيض'),
        description: _T(
          'Scramble the eggs in a hot wok, then set them aside.',
          'اعمل البيض مخفوق في طاسة سخنة وشيله على جنب.',
        ),
        baseDuration: Duration(minutes: 5),
      ),
      RecipeStep(
        title: _T('Fry the vegetables', 'شوّح الخضار'),
        description: _T(
          'Stir fry the peas and carrots for a few minutes.',
          'شوّح البسلة والجزر كام دقيقة.',
        ),
        baseDuration: Duration(minutes: 7),
      ),
      RecipeStep(
        title: _T('Fry the rice', 'تشويح الرز'),
        description: _T(
          'Add the rice and soy sauce, then fold the egg back in.',
          'ضيف الرز والصويا ورجّع البيض وقلّب.',
        ),
        baseDuration: Duration(minutes: 8),
      ),
    ],
  ),
  Recipe(
    id: 'steak-and-fries',
    name: _T('Steak & Fries', 'ستيك وبطاطس'),
    description: _T(
      'A perfectly seared steak with a peppery pan sauce and crispy fries.',
      'ستيك متحمر صح مع صوص الفلفل وبطاطس مقرمشة.',
    ),
    imageUrl: '$_img/vussxq1511882648.jpg',
    tags: [_Tag.meat, _Tag.potatoes, _Tag.sauce],
    diet: DietType.meat,
    servings: 2,
    ingredients: [
      Ingredient(
        name: _T('Sirloin steaks', 'ستيك سيرلوين'),
        quantity: _T('2', '٢'),
      ),
      Ingredient(
        name: _T('Potatoes', 'بطاطس'),
        quantity: _T('600 g', '٦٠٠ جرام'),
      ),
      Ingredient(
        name: _T('Butter', 'زبدة'),
        quantity: _T('2 tbsp', '٢ معلقة كبيرة'),
      ),
      Ingredient(
        name: _T('Black pepper', 'فلفل أسود'),
        quantity: _T('1 tsp', 'معلقة صغيرة'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Bake the fries', 'تسوية البطاطس'),
        description: _T(
          'Cut the potatoes into batons, toss in oil and bake until golden.',
          'قطّع البطاطس صوابع، قلّبها في زيت وادخلها الفرن لحد ما تحمر.',
        ),
        baseDuration: Duration(minutes: 10),
      ),
      RecipeStep(
        title: _T('Sear the steak', 'تحمير الستيك'),
        description: _T(
          'Sear 3 minutes per side, basting with butter. Rest.',
          'حمّر ٣ دقايق كل ناحية مع الزبدة وسيبه يرتاح.',
        ),
        baseDuration: Duration(minutes: 6),
      ),
      RecipeStep(
        title: _T('Make the pan sauce', 'صوص الطاسة'),
        description: _T(
          'Add pepper and a splash of cream to the pan and pour over the steak.',
          'ضيف فلفل وشوية كريمة في الطاسة وصبه على الستيك.',
        ),
        baseDuration: Duration(minutes: 4),
      ),
    ],
  ),
  Recipe(
    id: 'spicy-arrabiata-penne',
    name: _T('Spicy Arrabiata Penne', 'مكرونة بيني أرابياتا'),
    description: _T(
      'Penne in a fiery tomato sauce with garlic and red chili flakes.',
      'مكرونة بيني في صلصة طماطم حارة بالتوم والشطة.',
    ),
    imageUrl: '$_img/ustsqw1468250014.jpg',
    tags: [_Tag.pasta, _Tag.spicy, _Tag.tomato],
    diet: DietType.plant,
    servings: 4,
    ingredients: [
      Ingredient(
        name: _T('Penne', 'مكرونة بيني'),
        quantity: _T('400 g', '٤٠٠ جرام'),
      ),
      Ingredient(
        name: _T('Chopped tomatoes', 'طماطم مفرومة'),
        quantity: _T('400 g', '٤٠٠ جرام'),
      ),
      Ingredient(
        name: _T('Chili flakes', 'شطة مجروشة'),
        quantity: _T('1 tsp', 'معلقة صغيرة'),
      ),
      Ingredient(
        name: _T('Fresh basil', 'ريحان'),
        quantity: _T('A handful', 'حفنة'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Cook the penne', 'سلق المكرونة'),
        description: _T(
          'Boil the penne in salted water until al dente.',
          'اسلق المكرونة في مية بملح.',
        ),
        baseDuration: Duration(minutes: 10),
      ),
      RecipeStep(
        title: _T('Make the sauce', 'عمل الصلصة'),
        description: _T(
          'Fry garlic and chili in olive oil, add tomatoes and simmer.',
          'شوّح التوم والشطة في زيت الزيتون، ضيف الطماطم وسيبها تتسبك.',
        ),
        baseDuration: Duration(minutes: 10),
      ),
      RecipeStep(
        title: _T('Toss and garnish', 'التقليب والتزيين'),
        description: _T(
          'Toss the pasta through the sauce and top with basil.',
          'قلّب المكرونة في الصلصة ووشّها بالريحان.',
        ),
        baseDuration: Duration(minutes: 3),
      ),
    ],
  ),
  Recipe(
    id: 'shakshuka',
    name: _T('Shakshuka', 'شكشوكة'),
    description: _T(
      'Eggs gently poached in a spiced tomato and pepper sauce.',
      'بيض مستوي في صلصة طماطم وفلفل متبلة.',
    ),
    imageUrl: '$_img/g373701551450225.jpg',
    tags: [_Tag.eggs, _Tag.tomato, _Tag.breakfast],
    diet: DietType.plant,
    servings: 2,
    ingredients: [
      Ingredient(name: _T('Eggs', 'بيض'), quantity: _T('4', '٤')),
      Ingredient(
        name: _T('Chopped tomatoes', 'طماطم مفرومة'),
        quantity: _T('400 g', '٤٠٠ جرام'),
      ),
      Ingredient(
        name: _T('Red pepper', 'فلفل أحمر'),
        quantity: _T('1', 'واحدة'),
      ),
      Ingredient(
        name: _T('Cumin', 'كمون'),
        quantity: _T('1 tsp', 'معلقة صغيرة'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Soften the vegetables', 'تطرية الخضار'),
        description: _T(
          'Gently fry the onion and pepper until soft.',
          'شوّح البصل والفلفل على نار هادية لحد ما يطروا.',
        ),
        baseDuration: Duration(minutes: 8),
      ),
      RecipeStep(
        title: _T('Simmer the sauce', 'تسبيك الصلصة'),
        description: _T(
          'Add the spices and tomatoes and simmer until thickened.',
          'ضيف البهارات والطماطم وسيبها لحد ما تتقل.',
        ),
        baseDuration: Duration(minutes: 10),
      ),
      RecipeStep(
        title: _T('Poach the eggs', 'تسوية البيض'),
        description: _T(
          'Crack the eggs into the sauce, cover and cook until set.',
          'اكسر البيض في الصلصة، غطّيها وسيبها لحد ما البيض يستوي.',
        ),
        baseDuration: Duration(minutes: 7),
      ),
    ],
  ),
  Recipe(
    id: 'chickpea-fajitas',
    name: _T('Chickpea Fajitas', 'فاهيتا حمص'),
    description: _T(
      'Smoky roasted chickpeas and peppers wrapped in warm tortillas.',
      'حمص وفلفل مشويين بطعم مدخن ملفوفين في تورتيلا سخنة.',
    ),
    imageUrl: '$_img/tvtxpq1511464705.jpg',
    tags: [_Tag.vegan, _Tag.vegetables, _Tag.mexican],
    diet: DietType.plant,
    servings: 4,
    ingredients: [
      Ingredient(
        name: _T('Chickpeas', 'حمص'),
        quantity: _T('2 cans', '٢ علبة'),
      ),
      Ingredient(name: _T('Bell peppers', 'فلفل رومي'), quantity: _T('2', '٢')),
      Ingredient(
        name: _T('Smoked paprika', 'بابريكا مدخنة'),
        quantity: _T('2 tsp', '٢ معلقة صغيرة'),
      ),
      Ingredient(name: _T('Tortillas', 'تورتيلا'), quantity: _T('8', '٨')),
    ],
    steps: [
      RecipeStep(
        title: _T('Season the chickpeas', 'تتبيل الحمص'),
        description: _T(
          'Drain the chickpeas and toss with oil and spices.',
          'صفّي الحمص وقلّبه بالزيت والبهارات.',
        ),
        baseDuration: Duration(minutes: 5),
      ),
      RecipeStep(
        title: _T('Roast', 'الشوي'),
        description: _T(
          'Roast with sliced peppers and onion until charred.',
          'اشويه مع الفلفل والبصل لحد ما يتحمروا.',
        ),
        baseDuration: Duration(minutes: 20),
      ),
      RecipeStep(
        title: _T('Assemble', 'التجميع'),
        description: _T(
          'Warm the tortillas and fill with the roast and salsa.',
          'سخّن التورتيلا واحشيها بالخلطة والسالسا.',
        ),
        baseDuration: Duration(minutes: 5),
      ),
    ],
  ),
  Recipe(
    id: 'vegetarian-chilli',
    name: _T('Vegetarian Chilli', 'تشيلي نباتي'),
    description: _T(
      'A hearty bowl of beans, sweetcorn and peppers in a smoky tomato base.',
      'طبق غني من الفاصوليا والدرة والفلفل في صلصة طماطم مدخنة.',
    ),
    imageUrl: '$_img/wqurxy1511453156.jpg',
    tags: [_Tag.beans, _Tag.spicy, _Tag.vegetables],
    diet: DietType.plant,
    servings: 4,
    ingredients: [
      Ingredient(
        name: _T('Kidney beans', 'فاصوليا حمرا'),
        quantity: _T('2 cans', '٢ علبة'),
      ),
      Ingredient(name: _T('Sweetcorn', 'درة'), quantity: _T('1 can', 'علبة')),
      Ingredient(
        name: _T('Chopped tomatoes', 'طماطم مفرومة'),
        quantity: _T('400 g', '٤٠٠ جرام'),
      ),
      Ingredient(
        name: _T('Chili powder', 'شطة بودرة'),
        quantity: _T('2 tsp', '٢ معلقة صغيرة'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Fry the base', 'تشويح الأساس'),
        description: _T(
          'Fry the onion and garlic with the spices until fragrant.',
          'شوّح البصل والتوم مع البهارات لحد ما ريحتهم تطلع.',
        ),
        baseDuration: Duration(minutes: 7),
      ),
      RecipeStep(
        title: _T('Simmer', 'التسبيك'),
        description: _T(
          'Add tomatoes, beans and sweetcorn and simmer until thick.',
          'ضيف الطماطم والفاصوليا والدرة وسيبهم لحد ما يتقلوا.',
        ),
        baseDuration: Duration(minutes: 25),
      ),
      RecipeStep(
        title: _T('Season and serve', 'التتبيل والتقديم'),
        description: _T(
          'Adjust the seasoning and serve with rice or bread.',
          'ظبط الملح وقدّمه مع رز أو عيش.',
        ),
        baseDuration: Duration(minutes: 3),
      ),
    ],
  ),
  Recipe(
    id: 'teriyaki-chicken',
    name: _T('Teriyaki Chicken Casserole', 'صينية فراخ ترياكي'),
    description: _T(
      'Sticky homemade teriyaki chicken baked with vegetables over rice.',
      'فراخ بصوص الترياكي البيتي متسوية في الفرن مع الخضار وتتقدم على رز.',
    ),
    imageUrl: '$_img/wvpsxx1468256321.jpg',
    tags: [_Tag.chicken, _Tag.rice, _Tag.sauce],
    diet: DietType.meat,
    servings: 4,
    ingredients: [
      Ingredient(
        name: _T('Chicken thighs', 'أوراك فراخ'),
        quantity: _T('6', '٦'),
      ),
      Ingredient(
        name: _T('Soy sauce', 'صويا صوص'),
        quantity: _T('120 ml', '١٢٠ مل'),
      ),
      Ingredient(
        name: _T('Brown sugar', 'سكر بني'),
        quantity: _T('3 tbsp', '٣ معالق كبيرة'),
      ),
      Ingredient(name: _T('Rice', 'رز'), quantity: _T('2 cups', '٢ كوباية')),
    ],
    steps: [
      RecipeStep(
        title: _T('Make the teriyaki sauce', 'صوص الترياكي'),
        description: _T(
          'Simmer soy sauce, sugar, ginger and garlic, then thicken.',
          'سبّك الصويا والسكر والجنزبيل والتوم لحد ما يتقل.',
        ),
        baseDuration: Duration(minutes: 8),
      ),
      RecipeStep(
        title: _T('Cook the rice', 'طبخ الرز'),
        description: _T(
          'Rinse and cook the rice until fluffy.',
          'اغسل الرز واطبخه.',
        ),
        baseDuration: Duration(minutes: 15),
      ),
      RecipeStep(
        title: _T('Bake', 'التسوية في الفرن'),
        description: _T(
          'Layer chicken and vegetables, pour over the sauce and bake.',
          'رص الفراخ والخضار، صب الصوص وادخلها الفرن.',
        ),
        baseDuration: Duration(minutes: 25),
      ),
    ],
  ),
  Recipe(
    id: 'banana-pancakes',
    name: _T('Banana Pancakes', 'بان كيك بالموز'),
    description: _T(
      'Fluffy pancakes sweetened with ripe banana. A quick, cosy breakfast.',
      'بان كيك هش بالموز. فطار سريع ولذيذ.',
    ),
    imageUrl: '$_img/sywswr1511383814.jpg',
    tags: [_Tag.breakfast, _Tag.sweet, _Tag.eggs],
    diet: DietType.plant,
    servings: 2,
    ingredients: [
      Ingredient(name: _T('Ripe bananas', 'موز مستوي'), quantity: _T('2', '٢')),
      Ingredient(name: _T('Eggs', 'بيض'), quantity: _T('2', '٢')),
      Ingredient(name: _T('Flour', 'دقيق'), quantity: _T('100 g', '١٠٠ جرام')),
      Ingredient(name: _T('Milk', 'لبن'), quantity: _T('150 ml', '١٥٠ مل')),
    ],
    steps: [
      RecipeStep(
        title: _T('Mix the batter', 'خلط العجينة'),
        description: _T(
          'Mash the bananas, whisk in eggs and milk, then fold in the flour.',
          'اهرس الموز، اخفق معاه البيض واللبن، وبعدين ضيف الدقيق.',
        ),
        baseDuration: Duration(minutes: 5),
      ),
      RecipeStep(
        title: _T('Cook the pancakes', 'تسوية البان كيك'),
        description: _T(
          'Cook ladles of batter in a buttered pan until bubbles form, flip.',
          'صب مغرفة عجينة في طاسة بزبدة، ولما يطلع فقاقيع اقلبها.',
        ),
        baseDuration: Duration(minutes: 10),
      ),
    ],
  ),
];

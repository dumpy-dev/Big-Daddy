//
//  ArticlesTableViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 14/03/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit

class ArticlesTableViewController: UITableViewController {

    var articlesArray = [Article]()
    var filteredArticles = [Article]()
    let searchController = UISearchController(searchResultsController: nil)
    var fullVersionUnlocked = UserDefaults.standard.bool(forKey: "fullVersionUnlocked")
    
    @IBOutlet var upgradeButton: UIButton!
    @IBOutlet var upgradePopup: UIView!
    
    @IBAction func cancel(_ unwindSegue: UIStoryboardSegue){
    }

    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
            filteredArticles = articlesArray.filter({( articles : Article) -> Bool in
                return articles.keyword.lowercased().contains(searchText.lowercased())
            })
            tableView.reloadData()
        }
    
    func isFiltering() -> Bool {
            return searchController.isActive && !searchBarIsEmpty()
        }

    override func viewWillAppear(_ animated: Bool) {
        fullVersionUnlocked = UserDefaults.standard.bool(forKey: "fullVersionUnlocked")
        print("**ARTICLES SCREEN** Is full version unlocked? \(fullVersionUnlocked)")
        tableView.reloadData()
        var prefersStatusBarHidden: Bool {
            return true
        }
        if fullVersionUnlocked == true {
            self.upgradePopup.removeFromSuperview()
        } else {
            self.navigationController?.view.addSubview(upgradePopup)
            upgradePopup.center.x = self.view.center.x
            upgradePopup.frame.origin.y = self.view.frame.height / 1.2
            upgradePopup.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            upgradePopup.alpha = 0
            UIView.animate(withDuration: 0.8) {
                self.upgradePopup.alpha = 1
                self.upgradePopup.transform = CGAffineTransform.identity
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if fullVersionUnlocked == false {
            self.navigationController?.view.addSubview(upgradePopup)
            upgradePopup.center.x = self.view.center.x
            upgradePopup.frame.origin.y = self.view.frame.height / 1.2
            upgradePopup.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            upgradePopup.alpha = 0
            UIView.animate(withDuration: 0.8) {
                self.upgradePopup.alpha = 1
                self.upgradePopup.transform = CGAffineTransform.identity
                
            }
        }
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = convertToNSAttributedStringKeyDictionary([NSAttributedString.Key.foregroundColor.rawValue: UIColor.white])
        searchController.searchBar.tintColor = .white
      
        articlesArray = [
            Article(keyword:"alcohol pregnancy uk us france australia official advice avoid serious shirley airplane mother&rsquo;s blood baby liver organ develop process drinking drink first three months increase risk miscarriage premature birth low weight developmental problems heavily regularly serious condition foetal syndrome facial abnormalities learning difficulties restricted growth worry risk low gone off taste small batch organic craft IPA friday night cup of tea G&T gin tonic cucumber lime spirit alcohol-free", name:"Alcohol", unlocked: false),
             Article(keyword:"amniocentesis CVS chorionic villus sampling amniotic fluid placenta downs edwards&rsquo; patau&rsquo;s pataus chromosomal genetic problem condition test decision terminate pregnancy miscarriage abortion disability learning difficulties", name:"Amniocentesis", unlocked: false),
              Article(keyword:"pregnancy stick blue line announcement test miscarriage first trimester dating scan secret share news tell everyone bun in oven family tshirt t-shirt jumper grandma grandpa grandad uncle aunt pet dog cat line up shoes converse wellies arty picture photo bump ahead aston martin defibrillator james bond casino royale nobody expects the spanish inquisition monty python yippee ki yay die hard", name:"Announcing the Pregnancy", unlocked: true),
             Article(keyword:"anomaly scan dating due date 20 weeks sonographer antenatal appointment alien development problem abnormality heart defect cleft lip spina bifida gender investigate photo screening unpaid leave hasta la vista terminator casablanca here’s looking at you kid humphrey bogart", name:"Anomaly Scan", unlocked: false),
             Article(keyword:"antenatal class classes birth baby babies pain relief options labour changing nappy free NHS midwife GP private NCT WhatsApp mum dad night feed pub advice bonding hippy rubbish", name:"Antenatal Classes", unlocked: false),
             Article(keyword:"assisted birth instrumental delivery forceps ventouse suction cup deliver tired long labour baby awkward difficult position heart rate safe common risks tongs turn doctor midwife local anaesthetic episiotomy epidural room operating theatre top end stomach of iron risk tear third fourth continence urinary anal laugh new sofa greys grey’s anatomy barbecue bbq sausage guise moral support beard of zeus anchorman", name:"Assisted Delivery", unlocked: false),
             Article(keyword:"blood group type donate donor penguin biscuits A B O AB A- A+ B- B+ O- O+ AB- AB+ UK transfusion superheroes alien test rhesus positive negative antibodies pregnancy birth complications risk anaemia jaundice heart failure brain damage injection anti-D 28 weeks", name:"Blood Groups", unlocked: false),
             Article(keyword:"bonding bump morning sickness cravings olympic swimming pool baby ice cream shop haribo tangfastic sweets 16 weeks hear sounds outside inside womb listening conversations recognise voice sing songs read book playlist music born dream tiny addition normal worry worries anxiety talk scan alien camera kick wriggling champion kicker object cost financial friend talk chat road to fatherhood stress mini-me head start sleeping with the fishes godfather", name:"Bonding with the Bump", unlocked: false),
             Article(keyword:"braxton hicks contractions real fake practice practise practicing practising bump tense contracts relaxes common third trimester sex active exercise dehydration cheeky fakers pain painful uncomfortable irregular regular stop start change position don’t dont not stopping accompanied by other labour signs ghostbusters call midwife", name:"Braxton Hicks", unlocked: false),
             Article(keyword:"caesarian c-section section operation theatre surgery gestational diabetes breech emergency procedure labour progressing vaginal birth baby pre-eclampsia recovery plan pain anaesthetic general spinal infection delivery sunroof alien scar tummy hospital wizard of oz scrubs er george clooney doug ross", name:"Caesarean Section", unlocked: false),
             Article(keyword:"arnold arnie Schwarzenegger couvade syndrome men pregnant fiction bun oven dr hesse male pregnancy symptoms partner morning sickness bloating cravings food aversions mood swings anxiety poor concentration 1 in 10 dads-to-be belly emergency stash chocolate sympathy", name:"Couvade Syndrome", unlocked: false),
             Article(keyword:"cravings melon hormones late night shop chocolate sweets sour ice cream fruit pickles cheese meat spicy food ice heartburn tablets mustard toothpaste dry teabags bath bubbles mud chalk sand burnt matches pica inedible toxic non-food advice support midwife diet latin magpie pikachu electric spark mouse japan", name:"Cravings", unlocked: false),
             Article(keyword:"dad’s role during labour stay staying calm little book of comfortable bath music food snacks drink water loo toilet time timer contractions call midwife unit hospital advice when to go in panic worry worries regular five minutes strong 60 sixty seconds telephone take charge carry bags change positions offer high-energy keep going sponge forehead cold wet flannel silence talk keep her spirits up make her smile encouragement reassurance amazing job proud excited to meet baby shout hang onto pain all your fault communicate advocate epidural natural birth plan afraid ask questions doctor midwives every hour what to say pushing squeeze hand x-ray hurts deep breaths cry fresh air mum smile baby wingman top gun speed ain’t got time to bleed predator", name:"Dad's Role in Labour", unlocked: false),
             Article(keyword:"dating scan ultrasound sonographer hospital 12 weeks down’s downs down syndrome development twins alien photo screening due date antenatal appointment unpaid leave tom hanks castaway", name:"Dating Scan", unlocked: false),
             Article(keyword:"fh fhhr fhnh fmf fmnf heart heartbeat movement felt not felt heard regular blood pressure 120 70 systolic diastolic average urine sample pee pot protein glucose other things nad trace + ++ +++ baby baby’s position cephalic vx head down breech bottom LOA ROA LOP ROP left right occiput anterior posterior 1/5 2/5 3/5 4/5 head engaged pelvis midwife doctor enigma code understand", name:"Decoding Midwife Notes", unlocked: false),
             Article(keyword:"driving drive car vehicle pregnancy bump steering wheel feet pedals seatbelt lap belt journey travel distance long break hydrated accident", name:"Driving", unlocked: false),
             Article(keyword:"ectopic pregnancy miscarriage scan bleeding dizziness nausea sick discomfort pain blood test fallopian tube injection embryo rupture internal emergency GP surgery 999 grief bereavement counselling rare", name:"Ectopic Pregnancy", unlocked: false),
             Article(keyword:"exercise morning sickness nausea second first trimester swimming walking yoga deadlift hydrated fitness instructor pregnant pregnancy exhaust sport strenuous falling risk ice hockey contact lie flat", name:"Exercising", unlocked: false),
             Article(keyword:"feed feeding breastfeeding formula milk infant steak and chips diet varied man boobs mum breasts hard can’t cant world health organisation unicef who breast is best fed nutrients cheap immunity protection nutrients cheap easy difficult bottles steriliser on tap food pump express bottle midwife support cafe expert ready-made secret stash hide hidden alternative option expensive powder espresso machine", name:"Feeding (the baby)", unlocked: false),
             Article(keyword:"liver fava beans chianti alcohol foods to avoid can can’t eat runny eggs chicken duck goose quail mayonnaise mousse souffle red lion stamp UK soft hard cheese unpasteurised pasteurised shop bought homemade yoghurt cottage goat’s feta swiss parmesan stilton mozzarella cream stilton ricotta halloumi paneer farm restaurant eating out ice-cream ice peanuts pepperoni cured meat cooked ham pre-packed tuna steak tins mercury oily fish mackerel salmon trout herring white shellfish prawns mussels scallops clams langoustines smoked raw undercooked wild farmed sushi frozen freeze caffeine coke cola tea coffee chocolate salmonella white rinds brie baked camembert listeria blue gorgonzola danish roquefort cured toxoplasmosis pate haggis vitamin A supplements game lead pellets rabbit venison guinea fowl pigeon pheasant shark swordfish marlin liquorish root NHS venezuelan beaver cheese monty python", name:"Foods to Avoid", unlocked: false),
             Article(keyword:"gestational diabetes mellitus blood sugar levels urine sample test testing glucose tolerance finger prick chocolate sweets overweight bmi polycystic ovary syndrome ethnic family large big baby macrosomia shoulder dystopia pre-eclampsia eclampsia miscarriage premature stillbirth induction c-section caesarian section monitoring insulin injections tablets type 2 two meals snacks tea bath exercise diet yoga google recipes pie eating contest stand by me", name:"Gestational Diabetes", unlocked: false),
             Article(keyword:"guessing gender wee old wives tales baby sonographer ring dangle bump swing circles pendulum sweet salty morning sickness face glowing cream moody chilled high low heart rate 140 bpm beer fridge step right left foot time travelling machine 26 weeks high low blood pressure conception research mother’s intuition girl or boy delorean back to the future", name:"Guessing the Gender", unlocked: true),
             Article(keyword:"high blood pressure 120/80 140/90 systolic diastolic hypertension white coat midwife GP test pre-eclampsia eclampsia medication exercise active diet salt antenatal appointment george clooney", name:"High Blood Pressure", unlocked: false),
             Article(keyword:"holiday first second trimester sickness mood swings moodiness tiredness plane flight flying safe to 34 weeks doctor’s letter pregnancy due date airline airplane aeroplane long short haul compression stockings DVT deep vein thrombosis risk low insurance company sunshine vitamin D cover up suncream sunscreen midday shade illness sickness dehydration dangerous for mother and baby eating drinking take care bottled water safe bug food poisoning medicine check queasy travel morning complicated vaccines vaccinations doctor nurse GP anti malarial anti-malarial tablets possible reschedule exotic getaway freediving wing-suiting heliskiing cave diving high-altitude mountaineering falls falling over-exertion off limits horse riding skiing snow water scuba", name:"Holidays", unlocked: false),
             Article(keyword:"hypnobirthing meditation relaxation relax breathe breathing visualisation mindfulness labour pain relief calm script class hypnosis darren brown morgan freeman books cd nhs private", name:"Hypnobirthing", unlocked: false),
             Article(keyword:"induction labour sweep pessary gel hospital hormone prostaglandin oxytocin syntocinon drip labour contractions waters break caesarian section gestational diabetes high blood pressure epidural darts slow wifi boiler repair painful ", name:"Induction", unlocked: false),
             Article(keyword:"stages of labour pacing hospital corridors mum’s side brief gory details three musketeers lions BLT first second third cervix midwife home hospital unit travel longest 10cm contractions push deliver baby born placenta tea toast cuddles spinal tap godfather all about eve fasten your seatbelts bumpy ride ain’t heard nothing yet jazz singer spoiler alert", name:"Labour", unlocked: true),
             Article(keyword:"miscarriage statistics bleeding pain cramping 12 weeks 23 risk smoking age drinking drugs caffeine obesity symptoms GP hospital medication surgery sex contraception emotion grief bereavement support recurrent counselling", name:"Miscarriage", unlocked: true),
              Article(keyword:"morning sickness sick nausea vomiting vomit vomathon first second trimester hypermeresis gravidarum princess kate hospital treatment GP malnutrition dehydration midwife antiemetic medication tablets anti-sickness queasy eat drink ginger water sleep rest small meal greasy curry rice pasta crackers bread", name:"Morning Sickness", unlocked: false),
              Article(keyword:"labour pain relief punch punched face epidural anaesthetic anaesthetist spine numb mobile fluid drip blood pressure monitor baby lying lie down risk instrumental delivery prolong safe pethidine injection leg side effects nauseous dizzy breathing sick gas and air entonox oxygen nitrous oxide mask mouthpiece light headed reduce control breathe breathing slowly deeply TENS machine transcutaneous electrical nerve stimulation lower back early stages electrodes electric current pulses sticky pads wires endorphins hire buy warm bath birthing pool hospital maternity unit aromatherapy clary sage hypnotherapy massage NHS", name:"Pain Relief in Labour", unlocked: false),
              Article(keyword:"paternity shared parental maternity leave criteria qualify positive impact family postnatal depression illness development alcohol die early relationship two weeks earnings antenatal appointment annual holiday support mum dad hugs cups tea punch bags unpaid paid pay UK", name:"Paternity Leave", unlocked: false),
              Article(keyword:"postnatal depression mother father mum dad mums dads down 1 in 10 baby blues common tearful sad anxious dishwasher change the sheets put the kettle on cup of tea bottle feeding night feeds breastfeeding offer symptoms persistently feeling sad low hard to bond baby not interested in life not in touch with friends family enjoying enjoy life sleep sleepy insomnia nap difficulty concentrate concentration make decisions scary thoughts want to harm GP help support serious treatment untreated amazing life changing stressful exhausting nothing to be ashamed of mad take away exceptional circumstances PANDAS foundation samaritans really bad advice information online TLC", name:"Postnatal Depression", unlocked: true),
              Article(keyword:"postnatal depression mum dad men women studies statistics common mental health worries stressful emotional love baby lifestyle relationship change sleep deprivation financial sadness guilt returning to work symptoms very low avoiding friends cope coping guilty not good enough wanting to cry problems sleeping vivid nightmares panic attacks comfort eating loss appetite not hungry concentrating anxiety obsessing health safety self harm self-harm death exercise enjoy talk open up feelings GP Samaritans happy am i will be a good father", name:"Postnatal Depression in Dads", unlocked: true),
              Article(keyword:"pre-eclampsia eclampsia high blood pressure protein urine proteinuria midwife antenatal appointment GP severe headache swelling swollen face ankles feet hands blurred blurry vision flashing lights heartburn nausea vomiting rib pain placenta baby hospital monitoring induction caesarian section c-section 37 weeks medication fitting convulsions HELLP stroke hypertension", name:"Pre-eclampsia", unlocked: false),
              Article(keyword:"premature baby babies early pre term 24 37 weeks twins triplets induction c-section caesarian section pregnancy complications growth contractions waters break P-PROM labour rupture membranes infection antibiotics thermometer temperature quick risk developmental problems medical team don’t panic stay calm hold hand reassure neonatal unit incubator red skin downy hair lanugo supportive unsettling develop Tommy’s Tommys", name:"Premature Babies", unlocked: false),
              Article(keyword:"is it sex safe pregnancy bump braxton hicks contractions bleeding labour miscarriage anchorman octagon penis lost that loving feeling top gun", name:"Sex", unlocked: false),
              Article(keyword:"signs of labour cot hospital bag big bump kick off prepare get ready signs symptoms on the way waters breaking gush suspect maternity unit birth en caul amniotic sac intact very rare contractions starting braxton hicks real fake practice painful increase intensity stop start timer keep track persistent lower back pain tummy cramps brownish blood tinged mucus discharge funny disrupted sleep midwife midwives five minutes rules call telephone starting advice cannoli jelly baby babies scarface godfather", name:"Signs of Labour", unlocked: false),
              Article(keyword:"sleep sleepless night waking relax relaxation herbal tea camomile bath lavender essential aromatherapy oil candles music dinner digest bedroom light screen yoga breathing exercises early pillow support side back stillbirth risk second third trimester 16 sixteen weeks lie in", name:"Sleep", unlocked: false),
              Article(keyword:"smoking braveheart take our fags dangerous mother and baby cigarette harmful chemicals oxygen breathing movements stillbirth complications pregnancy labour premature baby underweight stop nicotine replacement therapy patches gum sprays tablets champ zyban liquorice smoke secondhand vaping helpline NHS", name:"Smoking", unlocked: false),
              Article(keyword:"top ten dad worries anxiety worry anxious what if something goes wrong during the birth labour after new baby care how are we going to look after a tiny human stop crying drop fun pints pub nights out sleep deprived cranky can we afford finances financial assistance help budget ready to be daddy father love my right away rubbish poonami movies real life mistakes feel talk cup of tea", name:"Top Ten New Dad Worries", unlocked: false),
              Article(keyword:"preparing for getting ready labour hospital bag 36 weeks toothbrush phone chargers handy list check off pack close supervision maternity pad breast batch cooking healthy meals gordon brown ramsay tasty supermarket nappy ready to drop online shop check out tea bags coffee snacks schedule delivery when you know you’ll be home youtube tutorial massage back shoulder hand foot feet practise practice new skills birth preferences talk through epidural water bath help speak for her important numbers hospital midwife family contact telephone mobile driving recce park parking machine change cash seat carseat how to get it in", name:"Top Tips to Get Ready for B-Day", unlocked: false),
              Article(keyword:"vaccinations flu jab winter bronchitis pneumonia complications baby whooping cough 16 32 weeks immunity placenta safe sore arm rhesus negative anti-D injection blood groups", name:"Vaccinations", unlocked: false),
              Article(keyword:"vitamin supplements job to remind her folic acid 400 micrograms how many much 12 weeks birth defects spina bifida conceive three months D 10 per day throughout pregnancy breastfeeding healthy bones teeth muscles sunshine winter A harmful don’t take do C iron calcium diet multivitamins important jamie oliver smelly football boots bedroom nutritious meal snack", name:"Vitamins", unlocked: false)
            ]
        tableView.reloadData()
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        if #available(iOS 9.1, *) {
            searchController.obscuresBackgroundDuringPresentation = false
        } else {
            // Fallback on earlier versions
        }
        searchController.searchBar.placeholder = "is it me you're looking for?"
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            // Fallback on earlier versions
        }
        definesPresentationContext = true
        }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func upgradePressed(_ sender: Any) {
        self.upgradePopup.removeFromSuperview()
        performSegue(withIdentifier: "upgradeArticlesSegue", sender: self)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredArticles.count
        }
        return articlesArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var article: Article
        if isFiltering() {
            article = filteredArticles[indexPath.row]
        } else {
            article = articlesArray[indexPath.row]
        }
        if fullVersionUnlocked == true {
            self.upgradePopup.removeFromSuperview()
            performSegue(withIdentifier: "articleSelectedSegue", sender: self)
        } else {
            if article.unlocked == true {
                self.upgradePopup.removeFromSuperview()
                performSegue(withIdentifier: "articleSelectedSegue", sender: self)
            } else {
                upgradeButton.wiggle()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier") as! ArticlesCustomTableViewCell
        var article: Article
        if isFiltering() {
            article = filteredArticles[indexPath.row]
        } else {
            article = articlesArray[indexPath.row]
        }
        cell.articleLabel!.text = article.name
       
        if fullVersionUnlocked == true {
           
            if article.unlocked == false {
                article.unlocked = true
            } else {
                print("articles already unlocked")
            }
            cell.articleLabel.alpha = 1
            cell.articlePadlock.alpha = 0
        } else if fullVersionUnlocked == false {
            
            if article.unlocked == true {
                //cell.articleLabel.text == "Miscarriage"
                cell.articleLabel.alpha = 1
                cell.articlePadlock.alpha = 0
                
            } else {
                cell.articleLabel.alpha = 0.6
                cell.articlePadlock.alpha = 1
            }
        }
        
        
        if indexPath.row % 2 == 0 {
                    cell.contentView.backgroundColor = UIColor(red:0.04, green:0.41, blue:0.49, alpha:1.0)
                } else {
                    cell.contentView.backgroundColor = UIColor(red:0.03, green:0.38, blue:0.49, alpha:1.0)
                }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "articleSelectedSegue" {

            let article: Article
         
            var selectedRowIndex = self.tableView.indexPathForSelectedRow
            if isFiltering() {
                article = filteredArticles[selectedRowIndex!.row]
            } else {
                article = articlesArray[selectedRowIndex!.row]
            }
            
            self.upgradePopup.removeFromSuperview()
            let articleSelected : ArticleViewController = segue.destination as! ArticleViewController
            articleSelected.articleID = article.name
    }
        
        }
}

extension ArticlesTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
      filterContentForSearchText(searchController.searchBar.text!)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSAttributedStringKeyDictionary(_ input: [String: Any]) -> [NSAttributedString.Key: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}

//extension UIButton {
//    
//    @objc func wiggle() {
//        let wiggleAnim = CABasicAnimation(keyPath: "position")
//        wiggleAnim.duration = 0.05
//        wiggleAnim.repeatCount = 8
//        wiggleAnim.autoreverses = true
//        wiggleAnim.fromValue = CGPoint(x: self.center.x - 4.0, y: self.center.y)
//        wiggleAnim.toValue = CGPoint(x: self.center.x + 4.0, y: self.center.y)
//        layer.add(wiggleAnim, forKey: "position")
//    }
//}

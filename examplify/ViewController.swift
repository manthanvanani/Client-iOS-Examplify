//
//  ViewController.swift
//  examplify
//
//  Created by Manthan Vanani on 05/03/25.
//

import UIKit

struct AppColors {
    static let topLinear = UIColor(hex: "#395268")
    static let bottomLinear = UIColor(hex: "#D5EEFA")
    static let leftLinear = UIColor(hex: "#F3F3F7")
    static let background = UIColor(hex: "#FFFEFF")
    static let options = UIColor(hex: "#F3F3F7")
    static let eyeIcon = UIColor(hex: "#333D4F")
    static let topText = UIColor(hex: "#F9FEFF")
    static let blueColor = UIColor(hex: "#11A7E5")
}

// UIColor Extension for Hex Support
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: CGFloat
        switch hex.count {
        case 6: // RGB (no alpha)
            r = CGFloat((int >> 16) & 0xFF) / 255.0
            g = CGFloat((int >> 8) & 0xFF) / 255.0
            b = CGFloat(int & 0xFF) / 255.0
        case 8: // ARGB
            r = CGFloat((int >> 16) & 0xFF) / 255.0
            g = CGFloat((int >> 8) & 0xFF) / 255.0
            b = CGFloat(int & 0xFF) / 255.0
        default:
            r = 0; g = 0; b = 0
        }
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}

class ViewController: UIViewController {
    
    
    //MARK: - VIEW-CONTROLLER FORMAT
    
    var selectedIndex : Int = 0{
        didSet{
            self.setupQuestionView()
        }
    }
    
    var timer: Timer?
    var totalSeconds = (1 * 60 * 60) + (41 * 60) // 1 hour 41 minutes in seconds
    
    //MARK: - VARIABLE
    var isFirst : Bool = false
    
    var model : [QuestionModel] = [QuestionModel](){
        didSet{
            self.collectionView?.reloadData()
        }
    }
    
    var numberOfQuestion : Int = 63{
        didSet{
            self.fetchData()
            self.selectedIndex = 0
        }
    }
    
    //MARK: - IBOUTLET
    
    @IBOutlet weak var outerHeaderView: UIView!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var bottomOuterView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelBottomQuestion: UILabel!
    @IBOutlet weak var labelBottomCurreuntQuestion: UILabel!
    
    @IBOutlet weak var buttonFlag: UIButton!
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var buttonPrevious: UIButton!
    
    @IBOutlet weak var buttonQuestion: UIButton!
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var labelAnswer: UILabel!
    @IBOutlet weak var buttonTimer: UIButton!
    
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelUserCode: UILabel!
    @IBOutlet weak var labelExamNumber: UILabel!
    
    
    
    //MARK: - DE-INIT
    deinit{  NotificationCenter.default.removeObserver(self) }
    
    
    //MARK: - MEMORY WARNING
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: - VIEW CONTROLLER LIFE CYCLES
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareUI()
        self.prepareColor()
        self.prepareTypography()
        self.prepareLocalization()
        self.setupCollectionView()
        self.tableViewSetup()
        self.fetchData()
        self.selectedIndex = 0
        self.startTimer()
        self.setupPanGesture()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isFirst{
            self.isFirst = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //        let vc = DashboardController()
        //        vc.modalPresentationStyle = .fullScreen
        //        self.present(vc, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate() // Stop timer when view disappears
    }
    
    func setupPanGesture(){
        let panGesture = UILongPressGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        panGesture.minimumPressDuration = 5 // seconds
        self.labelUserName.isUserInteractionEnabled = true
        self.labelUserName.addGestureRecognizer(panGesture)
        
        
        let panGesture1 = UILongPressGestureRecognizer(target: self, action: #selector(handlePan1(_:)))
        panGesture1.minimumPressDuration = 5 // seconds
        self.labelUserCode.isUserInteractionEnabled = true
        self.labelUserCode.addGestureRecognizer(panGesture1)
        
        let panGesture2 = UILongPressGestureRecognizer(target: self, action: #selector(handlePan2(_:)))
        panGesture2.minimumPressDuration = 5 // seconds
        self.labelBottomQuestion.isUserInteractionEnabled = true
        self.labelBottomQuestion.addGestureRecognizer(panGesture2)
        
        
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        longPressGesture.minimumPressDuration = 5 // seconds
        self.buttonQuestion.isUserInteractionEnabled = true
        buttonQuestion.addGestureRecognizer(longPressGesture)
        
        let longPressGesture1 = UILongPressGestureRecognizer(target: self, action: #selector(labelExamNumber(_:)))
        longPressGesture1.minimumPressDuration = 5 // seconds
        self.labelExamNumber.isUserInteractionEnabled = true
        labelExamNumber.addGestureRecognizer(longPressGesture1)
        
    }
    
    @objc func labelExamNumber(_ gesture: UILongPressGestureRecognizer) {
        print(#function)
        if gesture.state == .began {
            print("Button long pressed!")
            let vc = NameChangeController()
            vc.modalPresentationStyle = .overCurrentContext
            vc.keyboardType = .default
            vc.delegate = self
            vc.key = .number
            self.present(vc, animated: true)
        }
    }
    
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        print(#function)
        if gesture.state == .began {
            print("Button long pressed!")
            let curruntModel = self.model[self.selectedIndex]
            let vc = ChangeQuestionController()
            vc.model = curruntModel
            vc.modalPresentationStyle = .overCurrentContext
            vc.delegate = self
            self.present(vc, animated: true)
        }
    }
    
    @objc func handlePan(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let vc = NameChangeController()
            vc.modalPresentationStyle = .overCurrentContext
            vc.keyboardType = .default
            vc.delegate = self
            self.present(vc, animated: true)
        }
    }
    
    @objc func handlePan1(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let vc = NameChangeController()
            vc.modalPresentationStyle = .overCurrentContext
            vc.keyboardType = .default
            vc.delegate = self
            vc.key = .code
            self.present(vc, animated: true)
        }
    }
    
    @objc func handlePan2(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let vc = NameChangeController()
            vc.modalPresentationStyle = .overCurrentContext
            vc.keyboardType = .default
            vc.delegate = self
            vc.key = .numberOfQuestion
            self.present(vc, animated: true)
        }
    }
    
    func fetchData(){
        
        let questions: [QuestionModel] = [
            QuestionModel(
                question: "Patient with Goiter",
                options: [
                    OptionModel(key: "A", value: "3rd pharyngeal pouch", isAnswer: false),
                    OptionModel(key: "B", value: "3rd pharyngeal arch", isAnswer: false),
                    OptionModel(key: "C", value: "4th pharyngeal pouch", isAnswer: false),
                    OptionModel(key: "D", value: "Floor of pharynx", isAnswer: true)
                ]
            ),
            
            QuestionModel(
                question: "Which hormone is responsible for regulating blood sugar levels?",
                options: [
                    OptionModel(key: "A", value: "Insulin", isAnswer: true),
                    OptionModel(key: "B", value: "Glucagon", isAnswer: false),
                    OptionModel(key: "C", value: "Thyroxine", isAnswer: false),
                    OptionModel(key: "D", value: "Adrenaline", isAnswer: false)
                ]
            ),
            
            QuestionModel(
                question: "What is the primary function of the kidneys?",
                options: [
                    OptionModel(key: "A", value: "Produce digestive enzymes", isAnswer: false),
                    OptionModel(key: "B", value: "Filter blood and produce urine", isAnswer: true),
                    OptionModel(key: "C", value: "Regulate body temperature", isAnswer: false),
                    OptionModel(key: "D", value: "Control muscle movement", isAnswer: false)
                ]
            ),
            
            QuestionModel(
                question: "Where does protein digestion begin in the human body?",
                options: [
                    OptionModel(key: "A", value: "Mouth", isAnswer: false),
                    OptionModel(key: "B", value: "Stomach", isAnswer: true),
                    OptionModel(key: "C", value: "Small intestine", isAnswer: false),
                    OptionModel(key: "D", value: "Large intestine", isAnswer: false)
                ]
            ),
            
            QuestionModel(
                question: "Which part of the brain controls balance and coordination?",
                options: [
                    OptionModel(key: "A", value: "Cerebrum", isAnswer: false),
                    OptionModel(key: "B", value: "Cerebellum", isAnswer: true),
                    OptionModel(key: "C", value: "Medulla Oblongata", isAnswer: false),
                    OptionModel(key: "D", value: "Hypothalamus", isAnswer: false)
                ]
            ),
            
            QuestionModel(
                question: "Which blood cells help in blood clotting?",
                options: [
                    OptionModel(key: "A", value: "Red blood cells", isAnswer: false),
                    OptionModel(key: "B", value: "White blood cells", isAnswer: false),
                    OptionModel(key: "C", value: "Platelets", isAnswer: true),
                    OptionModel(key: "D", value: "Plasma", isAnswer: false)
                ]
            ),
            
            QuestionModel(
                question: "What is the powerhouse of the cell?",
                options: [
                    OptionModel(key: "A", value: "Nucleus", isAnswer: false),
                    OptionModel(key: "B", value: "Mitochondria", isAnswer: true),
                    OptionModel(key: "C", value: "Ribosome", isAnswer: false),
                    OptionModel(key: "D", value: "Endoplasmic reticulum", isAnswer: false)
                ]
            ),
            
            QuestionModel(
                question: "Which vitamin is essential for blood clotting?",
                options: [
                    OptionModel(key: "A", value: "Vitamin A", isAnswer: false),
                    OptionModel(key: "B", value: "Vitamin C", isAnswer: false),
                    OptionModel(key: "C", value: "Vitamin D", isAnswer: false),
                    OptionModel(key: "D", value: "Vitamin K", isAnswer: true)
                ]
            ),
            
            QuestionModel(
                question: "Which organ produces bile?",
                options: [
                    OptionModel(key: "A", value: "Pancreas", isAnswer: false),
                    OptionModel(key: "B", value: "Liver", isAnswer: true),
                    OptionModel(key: "C", value: "Gallbladder", isAnswer: false),
                    OptionModel(key: "D", value: "Stomach", isAnswer: false)
                ]
            ),
            
            QuestionModel(
                question: "What is the largest organ in the human body?",
                options: [
                    OptionModel(key: "A", value: "Heart", isAnswer: false),
                    OptionModel(key: "B", value: "Liver", isAnswer: false),
                    OptionModel(key: "C", value: "Skin", isAnswer: true),
                    OptionModel(key: "D", value: "Lungs", isAnswer: false)
                ]
            )
        ]
        
        
//        self.model.append( QuestionModel(
//            question: "I'll transcribe the text from the image:\nA 10-year-old child presented to the pediatric clinic complaining from frequent micturition especially at night with bad wetting and irritability. Laboratory finding indicates normal blood glucose level. The hormone which is responsible for this condition is secreted from:\nAnswers A - D:",
//            options: [
//                OptionModel(key: "A", value: "Anterior pituitary", isAnswer: false),
//                OptionModel(key: "B", value: "Follicular cell", isAnswer: false),
//                OptionModel(key: "C", value: "Neurohypophysis", isAnswer: true),
//                OptionModel(key: "D", value: "Adenohypophysis", isAnswer: false)
//            ]
//        ))
//
        
        self.model.removeAll()
        
        for i in 0...numberOfQuestion-1{
            if let q = questions.randomElement(){
                self.model.append(q)
            }
        }
        
    }
    
    func startTimer() {
        updateTimerLabel() // Initial update
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if totalSeconds > 0 {
            totalSeconds -= 1
            updateTimerLabel()
        } else {
            timer?.invalidate()
            timer = nil
            buttonTimer.setTitle("Time's up!", for: UIControl.State.normal)
        }
    }
    
    func updateTimerLabel() {
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        buttonTimer.setTitle(String(format: " %02d:%02d:%02d", hours, minutes, seconds), for: .normal)
    }
    
    //MARK: - NOTIFICATON METHODS
    
    
    func prepareUI(){
        DispatchQueue.main.async {
            self.buttonFlag.clipsToBounds = true
            self.buttonFlag.layer.cornerRadius = self.buttonFlag.frame.height/2
        }
    }
    
    func prepareColor(){
        DispatchQueue.main.async {
            self.outerHeaderView.backgroundColor = AppColors.topLinear
            self.headerView.backgroundColor = AppColors.topLinear
            
        }
    }
    
    func prepareTypography(){
        DispatchQueue.main.async {
            
        }
    }
    
    func prepareLocalization(){
        DispatchQueue.main.async {
            
        }
    }
    
    func prepareDataBinding(){
        DispatchQueue.main.async {
            
        }
    }
    
    func setupQuestionView(){
        
        guard self.model.indices.contains(self.selectedIndex) else {
            self.tableView?.reloadData()
            self.collectionView?.reloadData()
            return
        }
        
        
        let indexCount = self.model.count
        
        for index in 0...indexCount-1 {
            if let option = self.model[index].selectedOption{
                self.model[index].outline = .filled
            }else if index == self.selectedIndex{
                self.model[index].outline = .visible
            }else{
                self.model[index].outline = .outline
            }
        }
        
        self.buttonQuestion.setTitle("Question # \(self.selectedIndex+1) of \(self.model.count)", for: UIControl.State.normal)
        self.labelQuestion.text = self.model[self.selectedIndex].question ?? ""
        self.labelAnswer.text = "Answer 1 - 1"
        self.labelBottomQuestion.text = ""
        self.labelBottomCurreuntQuestion.text = "\(self.selectedIndex+1)"
        self.labelBottomQuestion.text = "OF \(self.model.count) QUESTIONS"
        
        self.setupFlagButton()
        
        if(self.model.count == self.selectedIndex + 1){
            self.buttonNext.setTitle("Finsh", for: .normal)
        }else{
            self.buttonNext.setTitle("Next", for: .normal)
        }
        
        self.tableView?.reloadData()
        self.collectionView?.reloadData()
    }
    
    func setupFlagButton(){
        let isFlag = self.model[self.selectedIndex].isflag
        self.buttonFlag.setTitleColor(isFlag ? UIColor.white : .systemGray2, for: .normal)
        self.buttonFlag.backgroundColor = isFlag ? UIColor.systemOrange : UIColor(hex: "#F2F1F6")
    }
    
    func goToNextQuestion() {
        if selectedIndex < model.count - 1 {
            selectedIndex += 1
            scrollToIndex(index: selectedIndex)
        }else{
            self.openAlert(sender: self.buttonNext)
        }
    }
    
    func goToPreviousQuestion() {
        if selectedIndex > 0 {
            selectedIndex -= 1
            scrollToIndex(index: selectedIndex)
        }
    }
    
    func openAlert(sender: UIButton) {
        let alertView = UIAlertController(title: "Are You Sure?", message: "", preferredStyle: .alert)
        
        alertView.addAction(UIAlertAction(title: "Finish", style: .destructive, handler: { (_) in
            if let mainController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FinishViewController") as? FinishViewController {
                mainController.modalPresentationStyle = .fullScreen
                self.present(mainController, animated: true)
            }
        }))
        
        alertView.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // Configure Popover for iPad
        if let popoverController = alertView.popoverPresentationController {
            popoverController.sourceView = sender // Attach to the button
            popoverController.sourceRect = sender.bounds // Show relative to the button
            popoverController.permittedArrowDirections = .any // Allow any arrow direction
        }
        
        self.present(alertView, animated: false)
    }
    
    // MARK: - Scroll to Selected Question
    func scrollToIndex(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func scrollToTop() {
        if model.count > 0 {
            let indexPath = IndexPath(item: 0, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
        }
    }
    
    func scrollToBottom() {
        if model.count > 0 {
            let indexPath = IndexPath(item: model.count - 1, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    //MARK: - IBACTION
    
    @IBAction func buttonFlagClick(_ sender : UIButton){
        guard self.model.indices.contains(self.selectedIndex) else { return }
        self.model[self.selectedIndex].isflag = !self.model[self.selectedIndex].isflag
        self.setupFlagButton()
    }
    
    @IBAction func buttonPreviousClick(_ sender : UIButton){
        self.goToPreviousQuestion()
    }
    
    @IBAction func buttonNextClick(_ sender : UIButton){
        self.goToNextQuestion()
    }
    
    @IBAction func buttonTopIndexClick(_ sender: UIButton) {
        self.scrollToTop()
    }
    
    @IBAction func buttonBottomIndexClick(_ sender: UIButton) {
        self.scrollToBottom()
    }
    
    
    @IBAction func buttonUsernameClick(_ sender: UIButton) {
        let vc = NameChangeController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    @IBAction func buttonUserCodeClick(_ sender: UIButton) {
        
    }
    
    @IBAction func buttonTimerClick(_ sender: UIButton) {
        let vc = ChangeTimerController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    //MARK: - NETWORKING
    
    //MARK: - SYSTEM DELEGATE & DATASOURCE
    
    //MARK: - CUSTOM DELEGATE & DATASOURCE
    
}



extension ViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    
    func setupCollectionView(){
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: CircleCollectionCell.identifier, bundle: nil), forCellWithReuseIdentifier: CircleCollectionCell.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width-30
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? CircleCollectionCell)?.prePareUI()
        if self.model.indices.count > indexPath.item {
            (cell as? CircleCollectionCell)?.configCell(model : self.model[indexPath.item], indexPath: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CircleCollectionCell.identifier, for: indexPath) as! CircleCollectionCell
        cell.configCell(model : self.model[indexPath.item], indexPath: indexPath)
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.item
        self.scrollToIndex(index: self.selectedIndex)
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableViewSetup(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: QuestionCell.identifier, bundle: nil), forCellReuseIdentifier: QuestionCell.identifier)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model[selectedIndex].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionCell.identifier) as! QuestionCell
        cell.selectionStyle = .none
        cell.configCell(model: self.model[self.selectedIndex], indexPath: indexPath)
        DispatchQueue.main.async{
            cell.prepareUI()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(self.model[selectedIndex].selectedOption?.key == self.model[selectedIndex].options[indexPath.row].key){
            self.model[selectedIndex].selectedOption = nil
            self.model[selectedIndex].outline = .visible
        }else{
            self.model[selectedIndex].selectedOption = self.model[selectedIndex].options[indexPath.row]
            self.model[selectedIndex].outline = .filled
        }
        
        self.tableView?.reloadData()
    }
    
}


extension ViewController : ChangeTimerControllerDelegate{
    func ChangeTimerControllerDidFinish(time: Int?) {
        guard let time = time else {
            return
        }
        self.timer?.invalidate()
        self.totalSeconds = time*60
        self.startTimer()
    }
    
    
}

extension ViewController : NameChangeControllerDelegate{
    
    func nameChangeControllerDidFinish(name: String?, key : ChangeKey) {
        switch key {
        case .name:
            self.labelUserName.text = name ?? self.labelUserName.text
            break;
        case .number:
            self.labelExamNumber.text = name ?? self.labelExamNumber.text
            break;
        case .code:
            self.labelUserCode.text = name ?? self.labelUserCode.text
            break;
        case .numberOfQuestion:
            guard let name = Int(name ?? "63") else { return }
            self.numberOfQuestion = name
        }
        
    }
    
}

extension ViewController : ChangeQuestionControllerDelegate{
    func updateInQuestion(model: QuestionModel?) {
        guard let model = model else{ return }
        if let index = self.model.indices.filter({self.model[$0].uuid == model.uuid}).first{
            self.model[index] = model
            let temp = self.selectedIndex
            self.selectedIndex = temp
        }
    }
}

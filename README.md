# LBSwipeViewControllers

Most of the mobile applications need to switch among view controllers like tab along with the swipe or just selecting it by tap just like in WhatsApp , paytm , Intagram,Windows Phone etc. It woks on the collectionView having view controllers in cell. you just need to call some methods. Any kind of UI can be changed by the properties or customizing xib or using your own. It is easy to use, reduce effort and well tested. Done worry about the collection just put it in code as in given sample. 
To use CPPageMenu :
(Swift 3)

1) copy CPPageMenu folder in your project

2) design your tab cell as per your requirement in CPTabCell.swift

3) Initialize a CPPageMenuVC object with  pageArray (title with corresponding VC)

  eg : -
  
    let pageMenuarray :[PageModal] = [PageModal(pageTitle: "Cat", pageVC: cpCatVC),PageModal(pageTitle: "Cow", pageVC: cowCX),PageModal(pageTitle: "Chat", pageVC: cpCatVC),PageModal(pageTitle: "ElephantElephant", pageVC: elephantVC)]
     
     pageMenuVC.pageArray = pageMenuarray


4) change the colour,size properties and so ther properties
   
     pageMenuVC.tabDefaultColor = UIColor(red: 46/255, green: 139/255, blue: 87/255, alpha: 1)
     pageMenuVC.tabSelectedColor = UIColor(red: 46/255, green: 130/255, blue: 87/255, alpha: 1)
     pageMenuVC.tabWidth = 40.0
 

5 ) navigate to CPPageMenuVC
Screen shots are:- 

![simulator screen shot 08-mar-2017 1 25 45 pm](https://cloud.githubusercontent.com/assets/26254298/23737749/0d3e02fa-04bb-11e7-933d-96d6c33c4209.png)
![simulator screen shot 09-mar-2017 11 24 04 am](https://cloud.githubusercontent.com/assets/26254298/23737782/39b82248-04bb-11e7-961c-9c6323e3f113.png)


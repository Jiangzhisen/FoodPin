//
//  TutorialView.swift
//  FoodPin
//
//  Created by 姜智森 on 2024/10/29.
//

import SwiftUI

struct TutorialView: View {
    let pageHeadings = ["CREATE YOUR OWN FOOD GUIDE", "SHOW YOU THE LOCATION", "DISCO VER GREAT RESTAURANTS"]
    let pageSubHeadings = ["Pin your favorite restaurants and create your own food gu ide",
                            "Search and locate your favorite restaurant on Maps",
                            "Find restaurants shared by your friends and other foodies"]
    let pageImages = ["onboarding-1", "onboarding-2", "onboarding-3"]
    
    @State private var currentPage = 0
    
    @AppStorage("hasViewedWalkthrough") var hasViewedWalkthrough: Bool = false
    
    @Environment (\.dismiss) var dismiss
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .systemIndigo
    }
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(pageHeadings.indices, id: \.self) { index in
                    TutorialPage(image: pageImages[index], heading: pageHeadings[index], subHeading: pageSubHeadings[index])
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .animation(.default, value: currentPage)
            
            VStack(spacing: 20) {
                Button(action: {
                    if currentPage < pageHeadings.count - 1 {
                        currentPage += 1
                    } else {
                        hasViewedWalkthrough = true
                        dismiss()
                    }
                }) {
                    Text(currentPage == pageHeadings.count - 1 ? "GET STARTED" : "NEXT")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding()
                        .padding(.horizontal, 50)
                        .background(Color(.systemIndigo))
                        .cornerRadius(25)
                }
                
                if currentPage < pageHeadings.count - 1 {
                    Button(action: {
                        hasViewedWalkthrough = true
                        dismiss()
                    }) {
                        Text("Skip")
                            .font(.headline)
                            .foregroundStyle(Color(.darkGray))
                    }
                }
            }
            .padding(.bottom)
        }
    }
}

struct TutorialPage: View {
    let image: String
    let heading: String
    let subHeading: String
    
    var body: some View {
        VStack(spacing: 70) {
            Image(image)
                .resizable()
                .scaledToFit()
            
            VStack(spacing: 10) {
                Text(heading)
                    .font(.headline)
                
                Text(subHeading)
                    .font(.body)
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .padding(.top)
    }
}

#Preview {
    TutorialView()
}

#Preview("TutorialPage", traits: .sizeThatFitsLayout) {
    TutorialPage(image: "onboarding-1", heading: "CREATE YOUR OWN FOOD GUIDE", subHeading: "Pin your favorite restaurants and create your own food guide") }

//
//  DetailPage.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import SwiftUI
import Kingfisher


struct DetailPage: View {
    @ObservedObject var viewModel: DetailPageViewModel
    
    var body: some View {
        VStack {
            if let cat = viewModel.cat {
                let processor = DownsamplingImageProcessor(size: CGSize(width: 200, height: 200))
                             |> RoundCornerImageProcessor(cornerRadius: 4)
                KFImage(URL(string: "https://cataas.com/cat/\(cat.id)")!)
                    .placeholder { Image(systemName: "cat") }
                        .setProcessor(processor)
                    .loadDiskFileSynchronously()
                    .cacheMemoryOnly()
                    .fade(duration: 0.25)
                    .onProgress { receivedSize, totalSize in  }
                    .onFailure { error in
                        print(error)
                    }
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                Text(cat.id).font(.title)
                Text(cat.tags.map({$0}).joined(separator: "-")).font(.body)
            }
        }
        .onAppear(perform: viewModel.fetchItemDetail)
    }
}

#Preview {
    DetailPage(viewModel: DetailPageViewModel(repository: CatRepository(api: CatAPI(), localStorage: CatLocalStorage()), catId: "abc"))
}

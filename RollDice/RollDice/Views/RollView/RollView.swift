// RollView.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct RollView: View {
  @EnvironmentObject var model: AppModel
  @StateObject private var vm = RollViewModel()
  
  func initView() {
    vm.initViewModel(model: model)
  }
  
  var body: some View {
    NavigationView {
      VStack {
        Text(model.diceInfoText)
        diceView
        Spacer()
        totalView
        Spacer()
        rollButton
      }
      .padding()
      .navigationBarTitle("Roll Dice")
      .toolbar { toolbar }
      .sheet(isPresented: $model.showingSettings) {
        SettingsView().environmentObject(model)
      }
    }
    .onAppear(perform: initView)
  }
  
  var rollingAnimation: Animation {
    vm.rolling
      ? Animation.linear(duration: 0.5).repeatForever(autoreverses: false)
      : Animation.linear(duration: 0)
  }
  
  var diceView: some View {
    HStack {
      ForEach(model.diceValues.indices, id: \.self) { index in
        DieView(value: model.diceValues[index])
          .rotation3DEffect(Angle(degrees: vm.rolling ? 360 : 0.0),
                            axis: (x: 0.0, y: 0.0, z: 1.0))
          .animation(rollingAnimation)
      }
    }
    .isHidden(model.hiddenDice)
    .frame(maxWidth: .infinity)
  }
  
  var totalView: some View {
    Group {
      Text("Rolling...")
        .font(.largeTitle)
        .padding()
        .foregroundColor(.white)
        .background(Color.gray)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .isHidden(!vm.rolling, remove: true)
      
      VStack {
        Text("Total")
          .font(.title)
        Text("\(model.totalValue)")
          .font(.largeTitle)
          .foregroundColor(.white)
          .frame(width: 150, height: 150)
          .background(Color.gray)
          .clipShape(RoundedRectangle(cornerRadius: 20))
      }
      .isHidden(vm.rolling || model.hiddenDice, remove: true)
    }
  }
  
  var rollButton: some View {
    Button(action: vm.onRollButtonTap) {
      Text("Roll Dice")
    }
    .padding()
    .font(.title)
    .foregroundColor(.white)
    .background(Color.accentColor)
    .clipShape(RoundedRectangle(cornerRadius: 20))
    .padding(.bottom)
    .disabled(vm.rolling)
  }
  
  var toolbar: some ToolbarContent {
    ToolbarItem(placement: .navigationBarTrailing) {
      Button(action: vm.onSettingsTap) {
        Image(systemName: "gearshape")
      }
    }
  }
}

struct RollView_Previews: PreviewProvider {  
  static var previews: some View {
    RollView().environmentObject(AppModel.preview)
  }
}

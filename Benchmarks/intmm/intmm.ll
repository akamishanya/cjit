; ModuleID = 'intmm.c'
source_filename = "intmm.c"

@seed = internal global i64 0, align 8
@rowsize = internal global i32 0, align 4
@ima = internal global ptr null, align 8
@imb = internal global ptr null, align 8
@imr = internal global ptr null, align 8

; Function Attrs: nounwind uwtable
define dso_local void @Initrand() #0 {
  store i64 74755, ptr @seed, align 8, !tbaa !5
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local i32 @Rand() #0 {
  %1 = load i64, ptr @seed, align 8, !tbaa !5
  %2 = mul nsw i64 %1, 1309
  %3 = add nsw i64 %2, 13849
  %4 = and i64 %3, 65535
  store i64 %4, ptr @seed, align 8, !tbaa !5
  %5 = load i64, ptr @seed, align 8, !tbaa !5
  %6 = trunc i64 %5 to i32
  ret i32 %6
}

; Function Attrs: nounwind uwtable
define dso_local void @InitMatrix(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %2, align 8, !tbaa !9
  call void @llvm.lifetime.start.p0(i64 4, ptr %3) #5
  call void @llvm.lifetime.start.p0(i64 4, ptr %4) #5
  call void @llvm.lifetime.start.p0(i64 4, ptr %5) #5
  store i32 1, ptr %4, align 4, !tbaa !11
  br label %6

6:                                                ; preds = %35, %1
  %7 = load i32, ptr %4, align 4, !tbaa !11
  %8 = load i32, ptr @rowsize, align 4, !tbaa !11
  %9 = icmp sle i32 %7, %8
  br i1 %9, label %10, label %38

10:                                               ; preds = %6
  store i32 1, ptr %5, align 4, !tbaa !11
  br label %11

11:                                               ; preds = %31, %10
  %12 = load i32, ptr %5, align 4, !tbaa !11
  %13 = load i32, ptr @rowsize, align 4, !tbaa !11
  %14 = icmp sle i32 %12, %13
  br i1 %14, label %15, label %34

15:                                               ; preds = %11
  %16 = call i32 @Rand()
  store i32 %16, ptr %3, align 4, !tbaa !11
  %17 = load i32, ptr %3, align 4, !tbaa !11
  %18 = load i32, ptr %3, align 4, !tbaa !11
  %19 = sdiv i32 %18, 120
  %20 = mul nsw i32 %19, 120
  %21 = sub nsw i32 %17, %20
  %22 = sub nsw i32 %21, 60
  %23 = load ptr, ptr %2, align 8, !tbaa !9
  %24 = load i32, ptr %4, align 4, !tbaa !11
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds ptr, ptr %23, i64 %25
  %27 = load ptr, ptr %26, align 8, !tbaa !9
  %28 = load i32, ptr %5, align 4, !tbaa !11
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds i32, ptr %27, i64 %29
  store i32 %22, ptr %30, align 4, !tbaa !11
  br label %31

31:                                               ; preds = %15
  %32 = load i32, ptr %5, align 4, !tbaa !11
  %33 = add nsw i32 %32, 1
  store i32 %33, ptr %5, align 4, !tbaa !11
  br label %11, !llvm.loop !13

34:                                               ; preds = %11
  br label %35

35:                                               ; preds = %34
  %36 = load i32, ptr %4, align 4, !tbaa !11
  %37 = add nsw i32 %36, 1
  store i32 %37, ptr %4, align 4, !tbaa !11
  br label %6, !llvm.loop !16

38:                                               ; preds = %6
  call void @llvm.lifetime.end.p0(i64 4, ptr %5) #5
  call void @llvm.lifetime.end.p0(i64 4, ptr %4) #5
  call void @llvm.lifetime.end.p0(i64 4, ptr %3) #5
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind uwtable
define dso_local void @Innerproduct(ptr noalias noundef %0, ptr noalias noundef %1, ptr noalias noundef %2, i32 noundef %3, i32 noundef %4, i32 noundef %5) #0 {
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  store ptr %0, ptr %7, align 8, !tbaa !9
  store ptr %1, ptr %8, align 8, !tbaa !9
  store ptr %2, ptr %9, align 8, !tbaa !9
  store i32 %3, ptr %10, align 4, !tbaa !11
  store i32 %4, ptr %11, align 4, !tbaa !11
  store i32 %5, ptr %12, align 4, !tbaa !11
  call void @llvm.lifetime.start.p0(i64 4, ptr %13) #5
  %14 = load ptr, ptr %7, align 8, !tbaa !9
  store i32 0, ptr %14, align 4, !tbaa !11
  store i32 1, ptr %13, align 4, !tbaa !11
  br label %15

15:                                               ; preds = %43, %6
  %16 = load i32, ptr %13, align 4, !tbaa !11
  %17 = load i32, ptr %12, align 4, !tbaa !11
  %18 = icmp sle i32 %16, %17
  br i1 %18, label %19, label %46

19:                                               ; preds = %15
  %20 = load ptr, ptr %7, align 8, !tbaa !9
  %21 = load i32, ptr %20, align 4, !tbaa !11
  %22 = load ptr, ptr %8, align 8, !tbaa !9
  %23 = load i32, ptr %10, align 4, !tbaa !11
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds ptr, ptr %22, i64 %24
  %26 = load ptr, ptr %25, align 8, !tbaa !9
  %27 = load i32, ptr %13, align 4, !tbaa !11
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds i32, ptr %26, i64 %28
  %30 = load i32, ptr %29, align 4, !tbaa !11
  %31 = load ptr, ptr %9, align 8, !tbaa !9
  %32 = load i32, ptr %13, align 4, !tbaa !11
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds ptr, ptr %31, i64 %33
  %35 = load ptr, ptr %34, align 8, !tbaa !9
  %36 = load i32, ptr %11, align 4, !tbaa !11
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds i32, ptr %35, i64 %37
  %39 = load i32, ptr %38, align 4, !tbaa !11
  %40 = mul nsw i32 %30, %39
  %41 = add nsw i32 %21, %40
  %42 = load ptr, ptr %7, align 8, !tbaa !9
  store i32 %41, ptr %42, align 4, !tbaa !11
  br label %43

43:                                               ; preds = %19
  %44 = load i32, ptr %13, align 4, !tbaa !11
  %45 = add nsw i32 %44, 1
  store i32 %45, ptr %13, align 4, !tbaa !11
  br label %15, !llvm.loop !17

46:                                               ; preds = %15
  call void @llvm.lifetime.end.p0(i64 4, ptr %13) #5
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local i32 @init(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca i32, align 4
  store i32 %0, ptr %3, align 4, !tbaa !11
  %9 = load i32, ptr %3, align 4, !tbaa !11
  store i32 %9, ptr @rowsize, align 4, !tbaa !11
  call void @llvm.lifetime.start.p0(i64 8, ptr %4) #5
  %10 = load i32, ptr %3, align 4, !tbaa !11
  %11 = add nsw i32 %10, 1
  %12 = sext i32 %11 to i64
  %13 = mul i64 4, %12
  %14 = load i32, ptr %3, align 4, !tbaa !11
  %15 = add nsw i32 %14, 1
  %16 = sext i32 %15 to i64
  %17 = mul i64 %13, %16
  %18 = call ptr @malloc(i64 noundef %17) #6
  store ptr %18, ptr %4, align 8, !tbaa !9
  %19 = load ptr, ptr %4, align 8, !tbaa !9
  %20 = icmp ne ptr %19, null
  br i1 %20, label %22, label %21

21:                                               ; preds = %1
  store i32 0, ptr %2, align 4
  store i32 1, ptr %5, align 4
  br label %136

22:                                               ; preds = %1
  call void @llvm.lifetime.start.p0(i64 8, ptr %6) #5
  %23 = load i32, ptr %3, align 4, !tbaa !11
  %24 = add nsw i32 %23, 1
  %25 = sext i32 %24 to i64
  %26 = mul i64 4, %25
  %27 = load i32, ptr %3, align 4, !tbaa !11
  %28 = add nsw i32 %27, 1
  %29 = sext i32 %28 to i64
  %30 = mul i64 %26, %29
  %31 = call ptr @malloc(i64 noundef %30) #6
  store ptr %31, ptr %6, align 8, !tbaa !9
  %32 = load ptr, ptr %6, align 8, !tbaa !9
  %33 = icmp ne ptr %32, null
  br i1 %33, label %36, label %34

34:                                               ; preds = %22
  %35 = load ptr, ptr %4, align 8, !tbaa !9
  call void @free(ptr noundef %35)
  store i32 0, ptr %2, align 4
  store i32 1, ptr %5, align 4
  br label %135

36:                                               ; preds = %22
  call void @llvm.lifetime.start.p0(i64 8, ptr %7) #5
  %37 = load i32, ptr %3, align 4, !tbaa !11
  %38 = add nsw i32 %37, 1
  %39 = sext i32 %38 to i64
  %40 = mul i64 4, %39
  %41 = load i32, ptr %3, align 4, !tbaa !11
  %42 = add nsw i32 %41, 1
  %43 = sext i32 %42 to i64
  %44 = mul i64 %40, %43
  %45 = call ptr @malloc(i64 noundef %44) #6
  store ptr %45, ptr %7, align 8, !tbaa !9
  %46 = load ptr, ptr %7, align 8, !tbaa !9
  %47 = icmp ne ptr %46, null
  br i1 %47, label %51, label %48

48:                                               ; preds = %36
  %49 = load ptr, ptr %4, align 8, !tbaa !9
  call void @free(ptr noundef %49)
  %50 = load ptr, ptr %6, align 8, !tbaa !9
  call void @free(ptr noundef %50)
  store i32 0, ptr %2, align 4
  store i32 1, ptr %5, align 4
  br label %134

51:                                               ; preds = %36
  %52 = load i32, ptr %3, align 4, !tbaa !11
  %53 = add nsw i32 %52, 1
  %54 = sext i32 %53 to i64
  %55 = call ptr @calloc(i64 noundef %54, i64 noundef 8) #7
  store ptr %55, ptr @ima, align 8, !tbaa !9
  %56 = load ptr, ptr @ima, align 8, !tbaa !9
  %57 = icmp ne ptr %56, null
  br i1 %57, label %62, label %58

58:                                               ; preds = %51
  %59 = load ptr, ptr %4, align 8, !tbaa !9
  call void @free(ptr noundef %59)
  %60 = load ptr, ptr %6, align 8, !tbaa !9
  call void @free(ptr noundef %60)
  %61 = load ptr, ptr %7, align 8, !tbaa !9
  call void @free(ptr noundef %61)
  store i32 0, ptr %2, align 4
  store i32 1, ptr %5, align 4
  br label %134

62:                                               ; preds = %51
  %63 = load i32, ptr %3, align 4, !tbaa !11
  %64 = add nsw i32 %63, 1
  %65 = sext i32 %64 to i64
  %66 = call ptr @calloc(i64 noundef %65, i64 noundef 8) #7
  store ptr %66, ptr @imb, align 8, !tbaa !9
  %67 = load ptr, ptr @imb, align 8, !tbaa !9
  %68 = icmp ne ptr %67, null
  br i1 %68, label %74, label %69

69:                                               ; preds = %62
  %70 = load ptr, ptr %4, align 8, !tbaa !9
  call void @free(ptr noundef %70)
  %71 = load ptr, ptr %6, align 8, !tbaa !9
  call void @free(ptr noundef %71)
  %72 = load ptr, ptr %7, align 8, !tbaa !9
  call void @free(ptr noundef %72)
  %73 = load ptr, ptr @ima, align 8, !tbaa !9
  call void @free(ptr noundef %73)
  store i32 0, ptr %2, align 4
  store i32 1, ptr %5, align 4
  br label %134

74:                                               ; preds = %62
  %75 = load i32, ptr %3, align 4, !tbaa !11
  %76 = add nsw i32 %75, 1
  %77 = sext i32 %76 to i64
  %78 = call ptr @calloc(i64 noundef %77, i64 noundef 8) #7
  store ptr %78, ptr @imr, align 8, !tbaa !9
  %79 = load ptr, ptr @imr, align 8, !tbaa !9
  %80 = icmp ne ptr %79, null
  br i1 %80, label %87, label %81

81:                                               ; preds = %74
  %82 = load ptr, ptr %4, align 8, !tbaa !9
  call void @free(ptr noundef %82)
  %83 = load ptr, ptr %6, align 8, !tbaa !9
  call void @free(ptr noundef %83)
  %84 = load ptr, ptr %7, align 8, !tbaa !9
  call void @free(ptr noundef %84)
  %85 = load ptr, ptr @ima, align 8, !tbaa !9
  call void @free(ptr noundef %85)
  %86 = load ptr, ptr @imb, align 8, !tbaa !9
  call void @free(ptr noundef %86)
  store i32 0, ptr %2, align 4
  store i32 1, ptr %5, align 4
  br label %134

87:                                               ; preds = %74
  call void @llvm.lifetime.start.p0(i64 4, ptr %8) #5
  store i32 0, ptr %8, align 4, !tbaa !11
  br label %88

88:                                               ; preds = %128, %87
  %89 = load i32, ptr %8, align 4, !tbaa !11
  %90 = load i32, ptr %3, align 4, !tbaa !11
  %91 = add nsw i32 %90, 1
  %92 = icmp slt i32 %89, %91
  br i1 %92, label %94, label %93

93:                                               ; preds = %88
  store i32 2, ptr %5, align 4
  call void @llvm.lifetime.end.p0(i64 4, ptr %8) #5
  br label %131

94:                                               ; preds = %88
  %95 = load ptr, ptr %4, align 8, !tbaa !9
  %96 = load i32, ptr %8, align 4, !tbaa !11
  %97 = load i32, ptr %3, align 4, !tbaa !11
  %98 = add nsw i32 %97, 1
  %99 = mul nsw i32 %96, %98
  %100 = sext i32 %99 to i64
  %101 = getelementptr inbounds i32, ptr %95, i64 %100
  %102 = load ptr, ptr @ima, align 8, !tbaa !9
  %103 = load i32, ptr %8, align 4, !tbaa !11
  %104 = sext i32 %103 to i64
  %105 = getelementptr inbounds ptr, ptr %102, i64 %104
  store ptr %101, ptr %105, align 8, !tbaa !9
  %106 = load ptr, ptr %6, align 8, !tbaa !9
  %107 = load i32, ptr %8, align 4, !tbaa !11
  %108 = load i32, ptr %3, align 4, !tbaa !11
  %109 = add nsw i32 %108, 1
  %110 = mul nsw i32 %107, %109
  %111 = sext i32 %110 to i64
  %112 = getelementptr inbounds i32, ptr %106, i64 %111
  %113 = load ptr, ptr @imb, align 8, !tbaa !9
  %114 = load i32, ptr %8, align 4, !tbaa !11
  %115 = sext i32 %114 to i64
  %116 = getelementptr inbounds ptr, ptr %113, i64 %115
  store ptr %112, ptr %116, align 8, !tbaa !9
  %117 = load ptr, ptr %7, align 8, !tbaa !9
  %118 = load i32, ptr %8, align 4, !tbaa !11
  %119 = load i32, ptr %3, align 4, !tbaa !11
  %120 = add nsw i32 %119, 1
  %121 = mul nsw i32 %118, %120
  %122 = sext i32 %121 to i64
  %123 = getelementptr inbounds i32, ptr %117, i64 %122
  %124 = load ptr, ptr @imr, align 8, !tbaa !9
  %125 = load i32, ptr %8, align 4, !tbaa !11
  %126 = sext i32 %125 to i64
  %127 = getelementptr inbounds ptr, ptr %124, i64 %126
  store ptr %123, ptr %127, align 8, !tbaa !9
  br label %128

128:                                              ; preds = %94
  %129 = load i32, ptr %8, align 4, !tbaa !11
  %130 = add nsw i32 %129, 1
  store i32 %130, ptr %8, align 4, !tbaa !11
  br label %88, !llvm.loop !18

131:                                              ; preds = %93
  call void @Initrand()
  %132 = load ptr, ptr @ima, align 8, !tbaa !9
  call void @InitMatrix(ptr noundef %132)
  %133 = load ptr, ptr @imb, align 8, !tbaa !9
  call void @InitMatrix(ptr noundef %133)
  store i32 1, ptr %2, align 4
  store i32 1, ptr %5, align 4
  br label %134

134:                                              ; preds = %131, %81, %69, %58, %48
  call void @llvm.lifetime.end.p0(i64 8, ptr %7) #5
  br label %135

135:                                              ; preds = %134, %34
  call void @llvm.lifetime.end.p0(i64 8, ptr %6) #5
  br label %136

136:                                              ; preds = %135, %21
  call void @llvm.lifetime.end.p0(i64 8, ptr %4) #5
  %137 = load i32, ptr %2, align 4
  ret i32 %137
}

; Function Attrs: allocsize(0)
declare ptr @malloc(i64 noundef) #2

declare void @free(ptr noundef) #3

; Function Attrs: allocsize(0,1)
declare ptr @calloc(i64 noundef, i64 noundef) #4

; Function Attrs: nounwind uwtable
define dso_local void @deinit() #0 {
  %1 = load ptr, ptr @ima, align 8, !tbaa !9
  %2 = getelementptr inbounds ptr, ptr %1, i64 0
  %3 = load ptr, ptr %2, align 8, !tbaa !9
  call void @free(ptr noundef %3)
  %4 = load ptr, ptr @imb, align 8, !tbaa !9
  %5 = getelementptr inbounds ptr, ptr %4, i64 0
  %6 = load ptr, ptr %5, align 8, !tbaa !9
  call void @free(ptr noundef %6)
  %7 = load ptr, ptr @imr, align 8, !tbaa !9
  %8 = getelementptr inbounds ptr, ptr %7, i64 0
  %9 = load ptr, ptr %8, align 8, !tbaa !9
  call void @free(ptr noundef %9)
  %10 = load ptr, ptr @ima, align 8, !tbaa !9
  call void @free(ptr noundef %10)
  %11 = load ptr, ptr @imb, align 8, !tbaa !9
  call void @free(ptr noundef %11)
  %12 = load ptr, ptr @imr, align 8, !tbaa !9
  call void @free(ptr noundef %12)
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local i32 @intmm() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 4, ptr %1) #5
  call void @llvm.lifetime.start.p0(i64 4, ptr %2) #5
  call void @llvm.lifetime.start.p0(i64 4, ptr %3) #5
  %4 = load i32, ptr @rowsize, align 4, !tbaa !11
  store i32 %4, ptr %3, align 4, !tbaa !11
  store i32 1, ptr %1, align 4, !tbaa !11
  br label %5

5:                                                ; preds = %32, %0
  %6 = load i32, ptr %1, align 4, !tbaa !11
  %7 = load i32, ptr %3, align 4, !tbaa !11
  %8 = icmp sle i32 %6, %7
  br i1 %8, label %9, label %35

9:                                                ; preds = %5
  store i32 1, ptr %2, align 4, !tbaa !11
  br label %10

10:                                               ; preds = %28, %9
  %11 = load i32, ptr %2, align 4, !tbaa !11
  %12 = load i32, ptr %3, align 4, !tbaa !11
  %13 = icmp sle i32 %11, %12
  br i1 %13, label %14, label %31

14:                                               ; preds = %10
  %15 = load ptr, ptr @imr, align 8, !tbaa !9
  %16 = load i32, ptr %1, align 4, !tbaa !11
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds ptr, ptr %15, i64 %17
  %19 = load ptr, ptr %18, align 8, !tbaa !9
  %20 = load i32, ptr %2, align 4, !tbaa !11
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds i32, ptr %19, i64 %21
  %23 = load ptr, ptr @ima, align 8, !tbaa !9
  %24 = load ptr, ptr @imb, align 8, !tbaa !9
  %25 = load i32, ptr %1, align 4, !tbaa !11
  %26 = load i32, ptr %2, align 4, !tbaa !11
  %27 = load i32, ptr @rowsize, align 4, !tbaa !11
  call void @Innerproduct(ptr noundef %22, ptr noundef %23, ptr noundef %24, i32 noundef %25, i32 noundef %26, i32 noundef %27)
  br label %28

28:                                               ; preds = %14
  %29 = load i32, ptr %2, align 4, !tbaa !11
  %30 = add nsw i32 %29, 1
  store i32 %30, ptr %2, align 4, !tbaa !11
  br label %10, !llvm.loop !19

31:                                               ; preds = %10
  br label %32

32:                                               ; preds = %31
  %33 = load i32, ptr %1, align 4, !tbaa !11
  %34 = add nsw i32 %33, 1
  store i32 %34, ptr %1, align 4, !tbaa !11
  br label %5, !llvm.loop !20

35:                                               ; preds = %5
  %36 = load ptr, ptr @imr, align 8, !tbaa !9
  %37 = getelementptr inbounds ptr, ptr %36, i64 1
  %38 = load ptr, ptr %37, align 8, !tbaa !9
  %39 = getelementptr inbounds i32, ptr %38, i64 1
  %40 = load i32, ptr %39, align 4, !tbaa !11
  call void @llvm.lifetime.end.p0(i64 4, ptr %3) #5
  call void @llvm.lifetime.end.p0(i64 4, ptr %2) #5
  call void @llvm.lifetime.end.p0(i64 4, ptr %1) #5
  ret i32 %40
}

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { allocsize(0) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "tune-cpu"="generic" }
attributes #3 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "tune-cpu"="generic" }
attributes #4 = { allocsize(0,1) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "tune-cpu"="generic" }
attributes #5 = { nounwind }
attributes #6 = { allocsize(0) }
attributes #7 = { allocsize(0,1) }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"Ubuntu clang version 19.1.2 (++20241028122730+d8752671e825-1~exp1~20241028122742.57)"}
!5 = !{!6, !6, i64 0}
!6 = !{!"long", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = !{!10, !10, i64 0}
!10 = !{!"any pointer", !7, i64 0}
!11 = !{!12, !12, i64 0}
!12 = !{!"int", !7, i64 0}
!13 = distinct !{!13, !14, !15}
!14 = !{!"llvm.loop.mustprogress"}
!15 = !{!"llvm.loop.unroll.disable"}
!16 = distinct !{!16, !14, !15}
!17 = distinct !{!17, !14, !15}
!18 = distinct !{!18, !14, !15}
!19 = distinct !{!19, !14, !15}
!20 = distinct !{!20, !14, !15}

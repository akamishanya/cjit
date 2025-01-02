; ModuleID = 'pi.c'
source_filename = "pi.c"

; Function Attrs: nounwind uwtable
define dso_local void @myadd(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8, !tbaa !5
  store ptr %1, ptr %4, align 8, !tbaa !5
  %5 = load ptr, ptr %3, align 8, !tbaa !5
  %6 = load float, ptr %5, align 4, !tbaa !9
  %7 = load ptr, ptr %4, align 8, !tbaa !5
  %8 = load float, ptr %7, align 4, !tbaa !9
  %9 = fadd float %6, %8
  %10 = load ptr, ptr %3, align 8, !tbaa !5
  store float %9, ptr %10, align 4, !tbaa !9
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local double @pi() #0 {
  %1 = alloca float, align 4
  %2 = alloca float, align 4
  %3 = alloca float, align 4
  %4 = alloca float, align 4
  %5 = alloca float, align 4
  %6 = alloca float, align 4
  %7 = alloca float, align 4
  %8 = alloca float, align 4
  %9 = alloca float, align 4
  %10 = alloca i64, align 8
  %11 = alloca i64, align 8
  %12 = alloca i64, align 8
  %13 = alloca i64, align 8
  %14 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 4, ptr %1) #3
  call void @llvm.lifetime.start.p0(i64 4, ptr %2) #3
  call void @llvm.lifetime.start.p0(i64 4, ptr %3) #3
  call void @llvm.lifetime.start.p0(i64 4, ptr %4) #3
  call void @llvm.lifetime.start.p0(i64 4, ptr %5) #3
  call void @llvm.lifetime.start.p0(i64 4, ptr %6) #3
  call void @llvm.lifetime.start.p0(i64 4, ptr %7) #3
  call void @llvm.lifetime.start.p0(i64 4, ptr %8) #3
  call void @llvm.lifetime.start.p0(i64 4, ptr %9) #3
  call void @llvm.lifetime.start.p0(i64 8, ptr %10) #3
  call void @llvm.lifetime.start.p0(i64 8, ptr %11) #3
  call void @llvm.lifetime.start.p0(i64 8, ptr %12) #3
  call void @llvm.lifetime.start.p0(i64 8, ptr %13) #3
  call void @llvm.lifetime.start.p0(i64 8, ptr %14) #3
  store float 0.000000e+00, ptr %1, align 4, !tbaa !9
  store i64 1, ptr %10, align 8, !tbaa !11
  store i64 1907, ptr %11, align 8, !tbaa !11
  store float 5.813000e+03, ptr %2, align 4, !tbaa !9
  store float 1.307000e+03, ptr %3, align 4, !tbaa !9
  store float 5.471000e+03, ptr %4, align 4, !tbaa !9
  store i64 40000000, ptr %12, align 8, !tbaa !11
  store i64 1, ptr %13, align 8, !tbaa !11
  br label %15

15:                                               ; preds = %60, %0
  %16 = load i64, ptr %13, align 8, !tbaa !11
  %17 = load i64, ptr %12, align 8, !tbaa !11
  %18 = icmp sle i64 %16, %17
  br i1 %18, label %19, label %63

19:                                               ; preds = %15
  %20 = load i64, ptr %11, align 8, !tbaa !11
  %21 = mul nsw i64 27611, %20
  store i64 %21, ptr %14, align 8, !tbaa !11
  %22 = load i64, ptr %14, align 8, !tbaa !11
  %23 = load i64, ptr %14, align 8, !tbaa !11
  %24 = sdiv i64 %23, 74383
  %25 = mul nsw i64 74383, %24
  %26 = sub nsw i64 %22, %25
  store i64 %26, ptr %11, align 8, !tbaa !11
  %27 = load i64, ptr %11, align 8, !tbaa !11
  %28 = sitofp i64 %27 to float
  %29 = fpext float %28 to double
  %30 = fdiv double %29, 7.438300e+04
  %31 = fptrunc double %30 to float
  store float %31, ptr %5, align 4, !tbaa !9
  %32 = load float, ptr %3, align 4, !tbaa !9
  %33 = load float, ptr %2, align 4, !tbaa !9
  %34 = fmul float %32, %33
  store float %34, ptr %9, align 4, !tbaa !9
  %35 = load float, ptr %9, align 4, !tbaa !9
  %36 = load float, ptr %4, align 4, !tbaa !9
  %37 = load float, ptr %9, align 4, !tbaa !9
  %38 = load float, ptr %4, align 4, !tbaa !9
  %39 = fdiv float %37, %38
  %40 = fptosi float %39 to i64
  %41 = sitofp i64 %40 to float
  %42 = fneg float %36
  %43 = call float @llvm.fmuladd.f32(float %42, float %41, float %35)
  store float %43, ptr %2, align 4, !tbaa !9
  %44 = load float, ptr %2, align 4, !tbaa !9
  %45 = load float, ptr %4, align 4, !tbaa !9
  %46 = fdiv float %44, %45
  store float %46, ptr %6, align 4, !tbaa !9
  %47 = load float, ptr %5, align 4, !tbaa !9
  %48 = load float, ptr %5, align 4, !tbaa !9
  %49 = load float, ptr %6, align 4, !tbaa !9
  %50 = load float, ptr %6, align 4, !tbaa !9
  %51 = fmul float %49, %50
  %52 = call float @llvm.fmuladd.f32(float %47, float %48, float %51)
  store float %52, ptr %7, align 4, !tbaa !9
  call void @myadd(ptr noundef %1, ptr noundef %7)
  %53 = load float, ptr %7, align 4, !tbaa !9
  %54 = fpext float %53 to double
  %55 = fcmp ole double %54, 1.000000e+00
  br i1 %55, label %56, label %59

56:                                               ; preds = %19
  %57 = load i64, ptr %10, align 8, !tbaa !11
  %58 = add nsw i64 %57, 1
  store i64 %58, ptr %10, align 8, !tbaa !11
  br label %59

59:                                               ; preds = %56, %19
  br label %60

60:                                               ; preds = %59
  %61 = load i64, ptr %13, align 8, !tbaa !11
  %62 = add nsw i64 %61, 1
  store i64 %62, ptr %13, align 8, !tbaa !11
  br label %15, !llvm.loop !13

63:                                               ; preds = %15
  %64 = load i64, ptr %10, align 8, !tbaa !11
  %65 = sitofp i64 %64 to float
  %66 = fpext float %65 to double
  %67 = fmul double 4.000000e+00, %66
  %68 = load i64, ptr %12, align 8, !tbaa !11
  %69 = sitofp i64 %68 to float
  %70 = fpext float %69 to double
  %71 = fdiv double %67, %70
  %72 = fptrunc double %71 to float
  store float %72, ptr %8, align 4, !tbaa !9
  %73 = load float, ptr %8, align 4, !tbaa !9
  %74 = fpext float %73 to double
  call void @llvm.lifetime.end.p0(i64 8, ptr %14) #3
  call void @llvm.lifetime.end.p0(i64 8, ptr %13) #3
  call void @llvm.lifetime.end.p0(i64 8, ptr %12) #3
  call void @llvm.lifetime.end.p0(i64 8, ptr %11) #3
  call void @llvm.lifetime.end.p0(i64 8, ptr %10) #3
  call void @llvm.lifetime.end.p0(i64 4, ptr %9) #3
  call void @llvm.lifetime.end.p0(i64 4, ptr %8) #3
  call void @llvm.lifetime.end.p0(i64 4, ptr %7) #3
  call void @llvm.lifetime.end.p0(i64 4, ptr %6) #3
  call void @llvm.lifetime.end.p0(i64 4, ptr %5) #3
  call void @llvm.lifetime.end.p0(i64 4, ptr %4) #3
  call void @llvm.lifetime.end.p0(i64 4, ptr %3) #3
  call void @llvm.lifetime.end.p0(i64 4, ptr %2) #3
  call void @llvm.lifetime.end.p0(i64 4, ptr %1) #3
  ret double %74
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"Ubuntu clang version 19.1.2 (++20241028122730+d8752671e825-1~exp1~20241028122742.57)"}
!5 = !{!6, !6, i64 0}
!6 = !{!"any pointer", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = !{!10, !10, i64 0}
!10 = !{!"float", !7, i64 0}
!11 = !{!12, !12, i64 0}
!12 = !{!"long", !7, i64 0}
!13 = distinct !{!13, !14, !15}
!14 = !{!"llvm.loop.mustprogress"}
!15 = !{!"llvm.loop.unroll.disable"}

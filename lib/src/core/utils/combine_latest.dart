import 'dart:async';

Stream<R> combineLatest3<A, B, C, R>(
  Stream<A> a,
  Stream<B> b,
  Stream<C> c,
  R Function(A, B, C) combiner,
) {
  late StreamController<R> controller;
  A? lastA;
  B? lastB;
  C? lastC;
  bool hasA = false;
  bool hasB = false;
  bool hasC = false;

  late StreamSubscription<A> subA;
  late StreamSubscription<B> subB;
  late StreamSubscription<C> subC;

  void emit() {
    if (hasA && hasB && hasC) {
      controller.add(combiner(lastA as A, lastB as B, lastC as C));
    }
  }

  controller = StreamController<R>(
    onListen: () {
      subA = a.listen(
        (v) {
          lastA = v;
          hasA = true;
          emit();
        },
        onError: controller.addError,
      );
      subB = b.listen(
        (v) {
          lastB = v;
          hasB = true;
          emit();
        },
        onError: controller.addError,
      );
      subC = c.listen(
        (v) {
          lastC = v;
          hasC = true;
          emit();
        },
        onError: controller.addError,
      );
    },
    onCancel: () async {
      await subA.cancel();
      await subB.cancel();
      await subC.cancel();
    },
  );
  return controller.stream;
}

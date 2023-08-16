import 'dart:async';

import 'package:bloctest1/counter_event.dart';

class CounterBloc {
  int _counter = 0;

  final _counterStateController = StreamController<int>();
  StreamSink<int> get _inCounter => _counterStateController.sink;
  // For state, exposing only a stream which outputs data
  // Widgets will listen to this stream to get data (state)
  Stream<int> get counter => _counterStateController.stream;

  final _counterEventController = StreamController<CounterEvent>();
  // For events, exposing only a sink which is an input
  // UI will use this sink to put events into
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc() {
    // Whenever there is a new event (increment/decrement), we want to map it to a new state
    _counterEventController.stream.listen(_mapEventToState);
  }

  // This changes the state based on the parameter event
  void _mapEventToState(CounterEvent event) {
    if (event is IncrementEvent) {
      _counter++;
    } else {
      _counter--;
    }

    // Whenever there is a new state, we want to add it to _inCounter's sink
    _inCounter.add(_counter);
  }

  // This closes the StreamController so we don't get any memory leaks
  void dispose() {
    _counterStateController.close();
    _counterEventController.close();
  }
}
